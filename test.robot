*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser
Suite Teardown    Close Browser

*** Variables ***
${BASE_URL}       https://www.makemytrip.com
${DEPARTURE_CITY}    Delhi
${DESTINATION_CITY}  Mumbai
${DEPARTURE_DATE}    2024-12-25  # Format: YYYY-MM-DD

*** Test Cases ***
Search Flights on MakeMyTrip
    [Documentation]   This test searches for flights on MakeMyTrip.
    Open Home Page
    Select Departure City    ${DEPARTURE_CITY}
    Select Destination City  ${DESTINATION_CITY}
    Select Departure Date    ${DEPARTURE_DATE}
    Search Flights
    Validate Search Results

*** Keywords ***
Open Home Page
    Go To    ${BASE_URL}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath://*[@id='fromCity']    10s

Select Departure City
    [Arguments]    ${city}
    Click Element    xpath://*[@id='fromCity']
    Input Text       xpath://input[contains(@placeholder,'From')]    ${city}
    Wait Until Page Contains    ${city}    5s
    Press Key        xpath://input[contains(@placeholder,'From')]    RETURN

Select Destination City
    [Arguments]    ${city}
    Click Element    xpath://*[@id='toCity']
    Input Text       xpath://input[contains(@placeholder,'To')]    ${city}
    Wait Until Page Contains    ${city}    5s
    Press Key        xpath://input[contains(@placeholder,'To')]    RETURN

Select Departure Date
    [Arguments]    ${date}
    Click Element    xpath://label[contains(text(),'Departure')]
    Click Element    xpath://div[@aria-label='${date}']

Search Flights
    Click Element    xpath://a[contains(text(),'Search') or @id='search_button']
    Wait Until Page Contains Element    xpath://div[contains(@class, 'flight-container')]    20s

Validate Search Results
    Page Should Contain Element    xpath://div[contains(@class, 'flight-container')]
    Log    Flight search results displayed successfully.
