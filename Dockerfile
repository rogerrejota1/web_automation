FROM mcr.microsoft.com/playwright:v1.63.0-jammy

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PLAYWRIGHT_BROWSERS_PATH=/app/playwright-browsers
ENV BASE_URL=https://www.saucedemo.com

ENTRYPOINT ["pytest"]
CMD ["--junitxml=test-results/results.xml", "--html=reports/report.html", "--self-contained-html"]