from playwright.sync_api import Page, expect


class ProductsPage:

    def __init__(self, page: Page):
        self.page = page

        self.title = page.get_by_text("Products")
        self.shopping_cart = page.locator(".shopping_cart_link")

    def is_loaded(self) -> bool:
        expect(self.title).to_be_visible()
        return True

    def add_product(self, product_name: str):
        product = self.page.locator(
            ".inventory_item",
            has_text=product_name,
        )

        product.get_by_role(
            "button",
            name="Add to cart",
        ).click()

    def open_cart(self):
        self.shopping_cart.click()