// ==UserScript==
// @name         Księga Najlepszych Przepisów
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       Agnieszka
// @match        http://www.kwestiasmaku.com/przepis/*
// @match        http://kuchnialidla.pl/*
// @grant        none
// @require http://code.jquery.com/jquery-latest.js
// ==/UserScript==
/* jshint -W097 */
'use strict';

//$.getJSON("https://ksiega-najlepszych-przepisow.herokuapp.com/categories", function(result){
   //response data are now in the result variable
   //alert(JSON.stringify(result));
//});

url = "https://ksiega-najlepszych-przepisow.herokuapp.com/recipes/new?url=" + location.href;
link = $('<a>').attr('href', url).text("Kopiuj do Księgi");

// Kwestia smaku
$(".group-ikony").append(link);

//Lidl
li = $('<li>').append(link);
span = $("<span class='left-site-icon'></span>").append(link);
li.append(span);
$(".recipe_main .recipe_meta #recipe_meta_2").append(li);
