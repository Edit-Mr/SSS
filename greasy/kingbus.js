// ==UserScript==
// @name         Kingbus Autofill + Submit
// @namespace    http://tampermonkey.net/
// @version      1.1
// @description  Autofill and submit Kingbus order form step by step
// @match        https://order.kingbus.com.tw/ORD/ORD_M_1510_OrderGo.aspx
// @grant        none
// ==/UserScript==

(function () {
    'use strict';

    // Helper: wait until element exists
    function waitForElement(selector, callback) {
        const observer = new MutationObserver(() => {
            const el = document.querySelector(selector);
            if (el) {
                observer.disconnect();
                callback(el);
            }
        });
        observer.observe(document.body, { childList: true, subtree: true });
    }

    // Step 1: Fill passenger info and click OK
    waitForElement('#ctl00_ContentPlaceHolder1_txtCustomer_ID', () => {
        document.querySelector('#ctl00_ContentPlaceHolder1_txtCustomer_ID').value = 'A123456789';
        document.querySelector('#ctl00_ContentPlaceHolder1_txtPhone').value = '0900000000';
        document.querySelector('#ctl00_ContentPlaceHolder1_txtCustomer_N').value = '姓名';
        document.querySelector('#ctl00_ContentPlaceHolder1_txtE_mail').value = 'info@elvismao.com';

        document.querySelector('#ctl00_ContentPlaceHolder1_btnStep1_OK').click();
    });

    // Step 2: Wait for "From station"
    waitForElement('#ctl00_ContentPlaceHolder1_ddlStation_ID_From', (fromSelect) => {
        setTimeout(() => {
            fromSelect.value = 'D23'; // 清大
            fromSelect.dispatchEvent(new Event('change', { bubbles: true }));
            // Step 2a: Wait for "To station" to have 台中
            waitForElement('#ctl00_ContentPlaceHolder1_ddlStation_ID_To option[value="G67"]', () => {
                const toSelect = document.querySelector('#ctl00_ContentPlaceHolder1_ddlStation_ID_To');
                toSelect.value = 'G67'; // 台中

                // Step 2b: Fill date with today's date
                const today = new Date((new Date()).getTime() + 2.5 * 60 * 60 * 1000);
                const yyyy = today.getFullYear();
                const mm = String(today.getMonth() + 1).padStart(2, '0');
                const dd = String(today.getDate()).padStart(2, '0');
                const formatted = `${yyyy}/${mm}/${dd}`;

                let hour = today.getHours();
                let minute = today.getMinutes();

                // Round minutes up to the next 10
                minute = Math.ceil(minute / 10) * 10;
                if (minute === 60) {
                    minute = 0;
                    hour = (hour + 1) % 24;
                }

                document.querySelector('#ctl00_ContentPlaceHolder1_txtOut_Dt').value = formatted;
                document.querySelector('#ctl00_ContentPlaceHolder1_ddlHour').value = hour.toString().padStart(2, "0")
                document.querySelector('#ctl00_ContentPlaceHolder1_ddlMinute').value = minute.toString().padStart(2, "0");

                // Step 2c: Click Step 2 OK
                document.querySelector('#ctl00_ContentPlaceHolder1_btnStep2_OK').click();
            });
        });
    });
})();
