import pytest
from playwright.sync_api import Page

from pages.login_page import LoginPage


@pytest.fixture
def app_page(page: Page) -> Page:
    return page


@pytest.fixture
def logged_in_page(app_page: Page) -> Page:
    login_page = LoginPage(app_page)

    login_page.open()
    login_page.login(
        "standard_user",
        "secret_sauce",
    )

    return app_page