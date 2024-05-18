// ==UserScript==
// @name         Save Domain History
// @namespace    https://elvismao.com
// @version      v1.0
// @description  Save History Domain
// @author       Elvis Mao
// @match        *://*/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=elvismao.com
// @grant        GM_addElement
// ==/UserScript==

(function() {
    'use strict';
    GM_addElement(document.body, 'img', {
        src: 'https://pc.elvismao.com/site/'+window.location.hostname,
        style: 'width: 0; height: 0; visibility:none;',
    });
})();
