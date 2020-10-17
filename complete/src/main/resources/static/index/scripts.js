window.onload = function () {
    console.log(get_cookie("login_key"))
    if (get_cookie('login_key') == null) {
        console.log(get_cookie("login_key"))
        window.location = "/login"
    }

    // show_group()


    divisionStuds = function () {
        document.getElementById("division_body").setAttribute("style", "opacity:1; transition: 1s; height: 100%;");
        document.getElementById("divisionStuds").setAttribute("style", "display: none");
        document.getElementById("divisionStudsNone").setAttribute("style", "display: block");

    }

    divisionStudsNone = function () {
        document.getElementById("division_body").setAttribute("style", "display: none");
        document.getElementById("divisionStudsNone").setAttribute("style", "display: none");
        document.getElementById("divisionStuds").setAttribute("style", "display: block");

    }
    kurs = function () {
        document.getElementById("kurs_body").setAttribute("style", "opacity:1; transition: 1s; height: 100%;");
        document.getElementById("kurs").setAttribute("style", "display: none");
        document.getElementById("kursNone").setAttribute("style", "display: block");

    }

    kursNone = function () {
        document.getElementById("kurs_body").setAttribute("style", "display: none");
        document.getElementById("kursNone").setAttribute("style", "display: none");
        document.getElementById("kurs").setAttribute("style", "display: block");

    }
    group = function () {
        document.getElementById("group_body").setAttribute("style", "opacity:1; transition: 1s; height: 100%;");
        document.getElementById("group").setAttribute("style", "display: none");
        document.getElementById("groupNone").setAttribute("style", "display: block");

    }

    groupNone = function () {
        document.getElementById("group_body").setAttribute("style", "display: none");
        document.getElementById("groupNone").setAttribute("style", "display: none");
        document.getElementById("group").setAttribute("style", "display: block");

    }

    function createDiv(className, value, id) {
        var input = document.createElement('input')
        input.type = 'button'
        input.className = className
        input.value = value
        input.id = id
        input.onclick = function () {
            divisionStudsNone()
            get_kurs(id)
            kurs()
        }
        return input;
    }

    function createKurs(className, value, id) {
        var input = document.createElement('input')
        input.type = 'button'
        input.className = className
        input.value = value
        input.id = id
        input.onclick = function () {
            kursNone()
            get_group(id, value)
            group()
        }
        return input;
    }

    function createGroup(className, value, id) {
        var input = document.createElement('input')
        input.type = 'button'
        input.className = className
        input.value = value
        input.id = id
        input.onclick = function () {
            groupNone()
            modal.style.display = "none"
            return_group(id)
            show_group()

        }
        return input;
    }

    function createTD(className) {
        var td = document.createElement('td')

        td.type = 'td'
        td.className = className
        td.style.width = '100px'
        td.style.height = '50px'


        return td;
    }

    function createP(className, value) {
        var p = document.createElement('output')
        p.type = 'output'
        p.className = className

        p.value = value


        return p;
    }
    function createRemowe(className, value, id, id_person) {
        var p = document.createElement('input')
        p.type = 'button'
        p.className = className
        p.id = id
        p.id_person = id_person
        console.log(id_person+"ok")
        p.value = value
        p.onclick = function () {
            delete_group(id, id_person)
            show_group()

        }

        return p;
    }

    delete_group = function (id, id_person) {

        console.log(id)
        console.log(id_person+"000")
        let xmlhttp = getXmlHttp()
        xmlhttp.open('POST', '/api', true)
        xmlhttp.setRequestHeader('Content-Type', 'application/json')

        xmlhttp.send(JSON.stringify({
            "idgruop": id,
            "id_person": id_person,
            "api_method": "delete_group"
        }))
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {
                    let answer = JSON.parse(xmlhttp.responseText)
                }
            }
        }
    }
    return_group = function (id) {

        let xmlhttp = getXmlHttp()
        xmlhttp.open('POST', '/api', true)
        xmlhttp.setRequestHeader('Content-Type', 'application/json')

        xmlhttp.send(JSON.stringify({
            "login_key": get_cookie('login_key'),
            "idgruop": id,
            "api_method": "return_group"
        }))
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {
                    let answer = JSON.parse(xmlhttp.responseText)
                }
            }
        }
    }
    get_kurs = function (id) {

        let modal_body = document.getElementById('kurs_body')
        modal_body.innerHTML = '';
        let xmlhttp = getXmlHttp()
        xmlhttp.open('POST', '/api', true)
        xmlhttp.setRequestHeader('Content-Type', 'application/json')

        xmlhttp.send(JSON.stringify({"idDiv": id, "api_method": "get_kurs"}))
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {
                    let answer = JSON.parse(xmlhttp.responseText)
                    if (answer) {
                        for (var i = 0; i < answer.length; i++) {
                            modal_body.appendChild(createKurs('login100-form-btn', answer[i]['kurs'], id));
                        }
                    }
                }
            }
        }
    }
    get_group = function (id, kurNum) {
        let modal_body = document.getElementById('group_body')
        modal_body.innerHTML = '';
        let xmlhttp = getXmlHttp()
        xmlhttp.open('POST', '/api', true)
        xmlhttp.setRequestHeader('Content-Type', 'application/json')

        xmlhttp.send(JSON.stringify({"idDiv": id, "kurNum": kurNum, "api_method": "get_group"}))
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {
                    let answer = JSON.parse(xmlhttp.responseText)
                    if (answer) {
                        for (var i = 0; i < answer.length; i++) {
                            modal_body.appendChild(createGroup('login100-form-btn', answer[i]['title'], answer[i]['idgruop']));
                        }
                    }
                }
            }
        }
    }
    get_division = function () {
        console.log("get_division")

        let modal_body = document.getElementById('division_body')
        modal_body.innerHTML = '';
        let xmlhttp = getXmlHttp()
        xmlhttp.open('POST', '/api', true)
        xmlhttp.setRequestHeader('Content-Type', 'application/json')

        xmlhttp.send(JSON.stringify({"api_method": "get_division"}))
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {
                    let answer = JSON.parse(xmlhttp.responseText)
                    if (answer) {

                        for (var i = 0; i < answer.length; i++) {
                            modal_body.appendChild(createDiv('login100-form-btn', answer[i]['shortTitle'], answer[i]['idDivision']));
                        }
                    }
                }
            }
        }
    }
    show_group = function () {

        console.log("show_group")
        let modal_body = document.getElementById('list_group')
        modal_body.innerHTML = '';
        let xmlhttp = getXmlHttp()
        xmlhttp.open('POST', '/api', true)
        xmlhttp.setRequestHeader('Content-Type', 'application/json')

        xmlhttp.send(JSON.stringify({"login_key": get_cookie('login_key'), "api_method": "show_group"}))
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {
                    let answer = JSON.parse(xmlhttp.responseText)
                    if (answer) {
                        console.log(answer[0]['id_person'])
                        for (var i = 0; i < answer.length; i++) {
                            let tr = document.createElement('tr')

                            modal_body.appendChild(tr);
                            tr.appendChild(createTD('group_out')).appendChild(createP('group_P', answer[i]["short_title"]));
                            tr.appendChild(createTD('group_out')).appendChild(createP('group_P', answer[i]["course"]));
                            tr.appendChild(createTD('group_out')).appendChild(createP('group_P', answer[i]["title"]));
                            tr.appendChild(createTD('group_out')).appendChild(createP('group_P', answer[i]["Codedirection"]));
                            tr.appendChild(createTD('group_out')).appendChild(createP('group_P', answer[i]["levelEducation"]));
                            tr.appendChild(createTD('group_out')).appendChild(createRemowe('close', 'X', answer[i]["idgruop"],answer[i]["id_person"] ));

                        }
                    }
                }
            }
        }
    }

    var modal = document.getElementById('myModal');
    var btn = document.getElementById("myBtn");
    show_group()
    btn.onclick = function () {
        get_division()
        modal.style.display = "block";
    }

    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }


}