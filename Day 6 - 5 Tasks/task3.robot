*** Settings ***
Library  SeleniumLibrary
Library     String

*** Variables ***
${login_btn}    dt_login_button
${submit}   //*[text()="Log in"]
${dropdown}     dt_core_account-info_acc-info
&{real_active}  //*[@class="dc-tabs__item dc-tabs__active dc-tabs__active--acc-switcher__list-tabs dc-tabs__item--top dc-tabs__item--acc-switcher__list-tabs"]
${demo_acc}     //*[@id="dt_core_account-switcher_demo-tab"]
${demo_balance}     //*[@id="dt_VRTC4795352"]/span
${market_type}  //*[text()="Forex"]
${underlying}    //*[@id="trade"]/div/div[1]/div/div/div[1]/div[1]/div/div[2]/div/div/div[2]/div[2]/div/div[3]/div[1]/div[3]


*** Keyword ***
Login
    [arguments]     ${email}        ${pw}
    open browser        https://app.deriv.com/      chrome
    maximize browser window
    wait until page does not contain element    dt_core_header_acc-info-preloader   60
    wait until page contains element    ${login_btn}     60
    click element   ${login_btn}
    wait until page contains element    ${submit}     60
    input text      txtEmail     ${email}
    input password      txtPass     ${pw}
    click element       ${submit}

Check Account
    wait until page does not contain element    dt_core_header_acc-info-preloader   60
    click element       ${dropdown}
    wait until page contains element    dt_core_account-switcher_demo-tab
    click element       dt_core_account-switcher_demo-tab
    click element   ${demo_balance}
    reload page

Select Contract
    set selenium implicit wait  3
    wait until page does not contain element    dt_core_header_acc-info-preloader   20
    wait until page does not contain element     //*[@class="chart-container__loader"]   20
    wait until page contains element    //*[@class="cq-symbol-select-btn"]     20
    click element       //*[@class="cq-symbol-select-btn"]
    set selenium implicit wait  3
    wait until page contains element    ${market_type}
    click element   ${market_type}
    wait until page contains element    ${underlying}  20
    click element   ${underlying}

Clear Input
    [arguments]     ${text_field}
    wait until page contains element     ${text_field}    20
    ${current_value}=   GET VALUE   ${text_field}
    ${value_length}=    Get Length  ${current_value}
    Repeat Keyword  ${value_length} times   PRESS KEYS  ${text_field}   BACKSPACE

Set Values
    wait until page contains element    //*[@id="dt_contract_dropdown"]/div[1]  20
    click element   //*[@id="dt_contract_dropdown"]/div[1]
    click element   //*[@id="dt_contract_high_low_item"]
    click element   //*[@id="dt_simple_toggle"]
    click element   //*[@id="dc_duration_toggle_item"]
    Clear Input         //*[@id="dt_advanced_duration_datepicker"]/div/div[1]/input
    input text  //*[@id="dt_advanced_duration_datepicker"]/div/div[1]/input     2
    click element   //*[@id="dc_payout_toggle_item"]
    Clear Input     //*[@id="dt_amount_input"]
    input text  //*[@id="dt_amount_input"]  15.50

Buy Contract
    set selenium implicit wait  3
    wait until page does not contain element    //*[@class="trade-container__fieldset-wrapper trade-container__fieldset-wrapper--disabled"]     20
    wait until page contains element    //*[@id="trade_container"]/div[4]/div/div/fieldset[2]/div/div[2]   20
    click element   //*[@id="trade_container"]/div[4]/div/div/fieldset[2]/div/div[2]


*** Test Cases ***
Deriv Login
    Login   ${my_email}     ${my_pw}

Check Account
    Check Account

Select Contract
    Select Contract

Setting Values
    Set Values

Buying Contract
    Buy Contract