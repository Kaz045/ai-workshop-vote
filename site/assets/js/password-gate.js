function toHex(buffer) {
  return Array.from(new Uint8Array(buffer))
    .map((byte) => byte.toString(16).padStart(2, "0"))
    .join("");
}

async function sha256(text) {
  const buffer = await crypto.subtle.digest(
    "SHA-256",
    new TextEncoder().encode(text),
  );
  return toHex(buffer);
}

function unlockGate(container) {
  const protectedContent = container.querySelector(".protected-content");
  const gatePanel = container.querySelector(".password-panel");

  if (gatePanel) {
    gatePanel.hidden = true;
  }

  if (protectedContent) {
    protectedContent.hidden = false;
  }
}

async function initPasswordGate(container) {
  const form = container.querySelector(".password-form");
  const input = container.querySelector("[data-password-input]");
  const status = container.querySelector("[data-password-status]");
  const expectedHash = container.dataset.passwordHash;
  const gateKey = container.dataset.gateKey;

  if (!form || !input || !status || !expectedHash || !gateKey) {
    return;
  }

  const stored = window.sessionStorage.getItem(gateKey);
  if (stored === expectedHash) {
    unlockGate(container);
    return;
  }

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const candidate = input.value.trim();
    if (!candidate) {
      status.textContent = "パスワードを入力してください。";
      return;
    }

    status.textContent = "確認しています…";

    try {
      const candidateHash = await sha256(candidate);
      if (candidateHash === expectedHash) {
        window.sessionStorage.setItem(gateKey, expectedHash);
        status.textContent = "認証に成功しました。";
        unlockGate(container);
        return;
      }
    } catch (error) {
      console.error(error);
    }

    status.textContent = "パスワードが一致しません。";
  });
}

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll("[data-password-gate]").forEach((container) => {
    initPasswordGate(container);
  });
});
