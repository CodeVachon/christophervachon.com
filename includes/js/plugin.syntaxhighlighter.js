!function(a){function b(a,b){for(var c in b){var d=new RegExp(b[c].pattern,"gi");if(a.html().match(d))return b[c].class}return"found"}a.fn.highlightSyntax=function(c){var d=a.extend({tab:"&nbsp;&nbsp;&nbsp;&nbsp;",definitions:{"default":[{"class":"string",pattern:"((?:\"|')[^\"']{0,}(?:\"|'))"},{"class":"regex",pattern:"(\\/[^\\/]+\\/[gim]{0,})"},{"class":"const",pattern:"(?:(var|new|function|private|if|else|for|in)\\s)"},{"class":"operator",pattern:"((?:[\\+\\-\\=\\!\\|\\:\\[\\]\\(\\)\\{\\}\\>\\<]|&amp;|&lt;|&gt;){1,}|(?:[^\\*\\/]\\/(?!\\/|\\*)))"},{"class":"comment",pattern:"\\/\\/[^\\(\\n|\\r)]+|\\/\\*|\\*\\/"}]}},c),e=a("<table>").addClass("syntax-highlighting").append(a("<tr>").append(a("<td>").addClass("gutter")).append(a("<td>").addClass("code"))),f=d.definitions.default,g="";for(var h in f)g+=f[h].pattern+"|";g="("+g.replace(/\|$/,"")+")";for(var i=new RegExp(g,"gi"),j=a(this).html().split(/\r\n|\r|\n|<br(?:\s\/)?>/g),k=j.length-1,l=0;k>=l;l++){var m=j[l].replace(/\t/g,d.tab);m=m.replace(i,"<span class='found'>$1</span>"),m=a("<div>").html(m||"&nbsp;"),e.find("td.gutter").append(a("<div>").html(l+1)),e.find("td.code").append(m)}return e.find("td.code .found").each(function(){a(this).removeClass("found").addClass(b(a(this),f))}),this.closest("pre").replaceWith(e)}}(jQuery);