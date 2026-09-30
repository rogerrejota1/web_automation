from playwright.sync_api import Page

from pages.login_page import LoginPage


def test_user_can_login(app_page: Page):
    login_page = LoginPage(app_page)

    login_page.open()
    login_page.login(
        "standard_user",
        "secret_sauce",
    )

    assert "inventory.html" in app_page.url