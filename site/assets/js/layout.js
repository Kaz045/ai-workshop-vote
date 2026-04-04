async function loadPartial(target) {
  const kind = target.dataset.include;
  if (!kind) {
    return;
  }

  const basePath = document.body.dataset.basePath || "./";
  const url = new URL(`${basePath}components/${kind}.html`, window.location.href);

  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Failed to load ${kind}`);
    }

    target.innerHTML = await response.text();
    target.querySelectorAll("[href^='./']").forEach((link) => {
      const href = link.getAttribute("href");
      if (!href) {
        return;
      }

      link.setAttribute("href", `${basePath}${href.slice(2)}`);
    });
  } catch (error) {
    target.innerHTML = "";
    console.error(error);
  }
}

async function initLayout() {
  const partials = Array.from(document.querySelectorAll("[data-include]"));
  await Promise.all(partials.map(loadPartial));

  const yearNodes = document.querySelectorAll("[data-current-year]");
  const currentYear = String(new Date().getFullYear());
  yearNodes.forEach((node) => {
    node.textContent = currentYear;
  });
}

document.addEventListener("DOMContentLoaded", () => {
  initLayout();
});
