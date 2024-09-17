let hData = [];
let hDataType = [];
window.addEventListener('message', function(event) {
    ed = event.data;
	if (ed.action === "textUI") {
		if (ed.show) {
			document.getElementById("TUKeyDivInside").innerHTML=`<span>${ed.key}</span>`;
			document.getElementById("textUIH4").innerHTML=ed.text;
			$("#textUI").show().css({bottom: "-10%", position:'absolute', display:'flex'}).animate({bottom: "4%"}, 800, function() {});
		} else {
			$("#textUI").show().css({bottom: "4%", position:'absolute', display:'flex'}).animate({bottom: "-10%"}, 800, function() {});
		}
    } else if (ed.action === "textUIUpdate") {
        document.getElementById("TUKeyDivInside").innerHTML=`<span>${ed.key}</span>`;
        document.getElementById("textUIH4").innerHTML=ed.text;
	} else if (ed.action === "show3DText") {
		show3DText(ed);
	} else if (ed.action === "hide3DText") {
        hData[ed.id] = false;
        if (document.getElementById(ed.id)) {
            $("#" + ed.id).remove();
        }
	} else if (ed.action === "update3DText") {
		if (document.getElementById(ed.id)) {
            document.getElementById(ed.id).classList.remove("ThreeDCircle");
			document.getElementById(ed.id).classList.remove("ThreeDTextMain");
            document.getElementById(ed.id).innerHTML="";
            hDataType[ed.id] = ed.type;
			if (ed.type === "svg") {
                document.getElementById(ed.id).classList.add("ThreeDCircle");
            } else if (ed.type === "text") {
                document.getElementById(ed.id).classList.add("ThreeDTextMain");
                if (ed.theme === "green") {
                    document.getElementById(ed.id).innerHTML=`<div id="ThreeDTextMainLeft"><div id="ThreeDTextMainLeftInside">${ed.key}</div></div><div id="ThreeDTextMainRight"><div id="ThreeDTextMainRightInside">${ed.text}</div></div>`;
                } else {
                    document.getElementById(ed.id).innerHTML=`<div id="ThreeDTextMainLeftRed"><div id="ThreeDTextMainLeftInsideRed">${ed.key}</div></div><div id="ThreeDTextMainRightRed"><div id="ThreeDTextMainRightInsideRed">${ed.text}</div></div>`;
                }
            }
        }
	} else if (ed.action === "update3DText2") {
        if (document.getElementById(ed.id)) {
            if (hDataType[ed.id] === "text") {
                if (ed.theme === "green") {
                    document.getElementById(ed.id).innerHTML=`<div id="ThreeDTextMainLeft"><div id="ThreeDTextMainLeftInside">${ed.key}</div></div><div id="ThreeDTextMainRight"><div id="ThreeDTextMainRightInside">${ed.text}</div></div>`;
                } else {
                    document.getElementById(ed.id).innerHTML=`<div id="ThreeDTextMainLeftRed"><div id="ThreeDTextMainLeftInsideRed">${ed.key}</div></div><div id="ThreeDTextMainRightRed"><div id="ThreeDTextMainRightInsideRed">${ed.text}</div></div>`;
                }
            }
        }
    }
})

function create3DText(data) {
    if (hData[data.id] === false || hData[data.id] === undefined) {
        hData[data.id] = true;
        let x = (data.x * 100) + '%';
        let y = (data.y * 100) + '%';
        let $svg = $(document.createElement('div'));
        hDataType[ed.id] = data.type;
        if (data.type === "svg") {
            $svg.addClass("ThreeDCircle");
            $svg.html(``);
        } else if (data.type === "text") {
            $svg.addClass("ThreeDTextMain");
            if (data.theme === undefined) {
                data.theme = "green";
            }
            if (data.theme === "green") {
                $svg.html(`<div id="ThreeDTextMainLeft"><div id="ThreeDTextMainLeftInside">${data.key}</div></div><div id="ThreeDTextMainRight"><div id="ThreeDTextMainRightInside">${data.text}</div></div>`);
            } else {
                $svg.html(`<div id="ThreeDTextMainLeftRed"><div id="ThreeDTextMainLeftInsideRed">${data.key}</div></div><div id="ThreeDTextMainRightRed"><div id="ThreeDTextMainRightInsideRed">${data.text}</div></div>`);
            }
        }
        $svg.attr("id", data.id);
        $svg.css('display', 'flex');
        $svg.css('left', x);
        $svg.css('top', y);
        $svg.fadeIn();
        return $svg;
    } else {
        let x = (data.x * 100) + '%';
        let y = (data.y * 100) + '%';
        document.getElementById(data.id).style.left = x;
        document.getElementById(data.id).style.top = y;
    }
}

function show3DText(data) {
	let $svg = create3DText(data);
	$('#body').append($svg);
}