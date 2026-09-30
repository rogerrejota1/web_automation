from playwright.sync_api import Page

from pages.products_page import ProductsPage


def test_products_page_is_displayed(logged_in_page: Page):
    products_page = ProductsPage(logged_in_page)

    assert products_page.is_loaded()