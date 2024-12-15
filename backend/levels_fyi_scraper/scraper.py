from playwright.sync_api import sync_playwright
from bs4 import BeautifulSoup
import pandas as pd
import random
import time


def scrape_levels_fyi():
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=False, args=["--start-maximized"])
        context = browser.new_context(viewport={"width": 1920, "height": 1080})
        page = context.new_page()

        print("Opening the login page...")
        page.goto('https://www.levels.fyi/login')

        print("Please log in manually. The scraper will continue once you're logged in.")
        input("Press Enter once you have successfully logged in and are redirected to the dashboard...")

        print("Navigating to the target data page...")
        page.goto('https://www.levels.fyi/t/software-engineer?country=254')
        page.wait_for_selector("table", timeout=60000)
        print("Table detected on the target page!")

        set_rows_per_page(page)

        print("Scraping data...")
        data = scrape_all_pages(page)

        save_to_csv(data)

        browser.close()


def set_rows_per_page(page):
    """Sets the table to show 50 rows per page."""
    try:
        print("Setting rows per page to 50...")
        
        rows_dropdown = page.locator("div[aria-labelledby='limit-select']")
        rows_dropdown.click()
        page.wait_for_timeout(random.uniform(500, 1000))

        option_50 = page.locator("li.MuiMenuItem-root:has-text('50')")
        option_50.click()
        page.wait_for_timeout(random.uniform(1000, 2000))

        print("Rows per page set to 50 successfully.")
    except Exception as e:
        print("Error setting rows per page:", e)

        

def human_scroll(page):
    """Mimics a human-like scrolling action."""
    print("Mimicking human scroll behavior...")
    page.evaluate("window.scrollTo(0, 0);")
    for i in range(0, 5000, random.randint(300, 500)):
        page.evaluate(f"window.scrollTo(0, {i});")
        time.sleep(random.uniform(0.5, 1.5))
    page.evaluate("window.scrollTo(0, 0);")
    print("Scrolling complete.")


def scrape_all_pages(page):
    """Scrapes data from all pages."""
    all_data = []
    page_number = 1

    while True:
        print(f"Scraping page {page_number}...")

        # Extract data from the current page
        extracted_data = extract_data(page)
        print(f"Extracted {len(extracted_data)} rows from page {page_number}.")
        all_data.extend(extracted_data)

        # Locate the 'Next' button
        next_button = page.locator("button.MuiButton-root:has(svg[data-testid='KeyboardArrowRightIcon'])")

        if next_button.is_visible() and next_button.is_enabled():
            print("Next button found. Navigating to the next page...")
            next_button.click()
            # Randomized delay for anti-bot
            page.wait_for_timeout(random.uniform(2000, 4000))
            page_number += 1
        else:
            print("No 'Next' button found or it is disabled. Pagination complete.")
            break

    return all_data



def extract_data(page):
    """Extracts table data from the current page."""
    content = page.content()
    soup = BeautifulSoup(content, "html.parser")
    data = []

    print("\n--- Debugging Table Rows ---")
    rows = soup.select("tr.MuiTableRow-root")
    print(f"Total rows detected: {len(rows)}")

    if len(rows) == 0:
        print("No rows detected! Check the row selector.")
        print("HTML structure of table:\n")
        print(soup.prettify())
        return []

    for i, row in enumerate(rows):
        try:
            if not row.find("td") or "blur-prompt" in row.get("id", ""):
                print(f"Skipping row {i} (not a valid salary row)")
                continue

            company = row.select_one('td:nth-of-type(1) a')
            company = company.get_text(strip=True) if company else "N/A"

            level = row.select_one('td:nth-of-type(2) p')
            level = level.get_text(strip=True) if level else "N/A"

            tag = row.select_one('td:nth-of-type(2) span')
            tag = tag.get_text(strip=True) if tag else "N/A"

            years_experience = row.select_one('td:nth-of-type(3) p')
            years_experience = years_experience.get_text(strip=True) if years_experience else "N/A"

            total_comp_div = row.select_one('td:nth-of-type(4) div p')
            total_compensation = total_comp_div.get_text(strip=True) if total_comp_div else "N/A"

            data.append({
                "Company": company,
                "Level": level,
                "Tag": tag,
                "Years of Experience": years_experience,
                "Total Compensation": total_compensation,
            })

        except Exception as e:
            print(f"Error extracting row {i}: {e}")

    print(f"Extracted {len(data)} rows from the current page.")
    return data



def save_to_csv(data):
    """Saves extracted data to a CSV file."""
    df = pd.DataFrame(data)
    df.to_csv("levels_fyi_data.csv", index=False)
    print("Data saved to levels_fyi_data.csv")


if __name__ == "__main__":
    scrape_levels_fyi()