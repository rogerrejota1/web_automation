from playwright.sync_api import Page, expect


class CartPage:
    def __init__(self, page: Page):
        self.page = page

        self.cart_title = page.get_by_text("Your Cart")

    def is_loaded(self) -> bool:
        expect(self.cart_title).to_be_visible()
        return True

    def has_product(self, product_name: str) -> bool:
        return self.page.locator(
            ".cart_item",
            has_text=product_name,
        ).is_visible()