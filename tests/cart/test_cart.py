from playwright.sync_api import Page

from pages.products_page import ProductsPage
from pages.cart_page import CartPage


def test_user_can_add_product_to_cart(logged_in_page: Page):
    products_page = ProductsPage(logged_in_page)
    cart_page = CartPage(logged_in_page)

    products_page.add_product("Sauce Labs Backpack")
    products_page.open_cart()

    assert cart_page.is_loaded()
    assert cart_page.has_product("Sauce Labs Backpack")