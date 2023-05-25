import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import io.qt.Backend 1.0

Window {
    visible: true
    width: 1000
    minimumWidth: 500
    height: 700
    minimumHeight: 200
    title: "Client"
    color: "#CED0D4"

    Backend {
        id: backend

        onStatusChanged: {
            //console.log(currentStatus);
            ti.append(addMsg(newStatus));
            if (currentStatus !== true)
            {
                btn_connect.enabled = true;
            }
        }
        onSomeMessage: {
            ti.append(addMsg(msg));
            if ( msg == "ROOM")
            {

            }
        }
        onSomeError: {
            ti.append(addMsg("Error! " + err));
            if (currentStatus !== true)
            {
                backend.disconnectClicked();
            }
            btn_connect.enabled = true;
        }
    }

    ColumnLayout
    {
        anchors.fill: parent
        anchors.margins: 10

        LayoutSection {
            height: status.height + 15
            color: backend.currentStatus ? "#CAF5CF" : "#EA9FA9"

            Text {
                id: status
                anchors.centerIn: parent
                text: backend.currentStatus ? "CONNECTED" : "DISCONNECTED"
                font.weight: Font.Bold
            }
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter

            BetterButton {
                id: btn_connect
                anchors.left: parent.left
                text: "Connect to server"
                color: enabled ? this.down ? "#78C37F" : "#87DB8D" : "gray"
                border.color: "#78C37F"
                onClicked: {

                    backend.connectClicked();
                    this.enabled = false;
                }
            }
            BetterButton {
                id: btn_disconnect
                enabled: !btn_connect.enabled
                anchors.right: parent.right
                text: "Disconnect from server"
                color: enabled ? this.down ? "#DB7A74" : "#FF7E79" : "gray"
                border.color: "#DB7A74"
                onClicked: {

                    backend.disconnectClicked();
                    btn_connect.enabled = true;
                }
            }
        }

        LayoutSection {
            Layout.fillHeight: true

            ScrollView {
                id: scrollView
                anchors.fill: parent

                TextArea {
                    id: ti
                    readOnly: true
                    selectByMouse : true
                    font.pixelSize: 14
                    wrapMode: TextInput.WrapAnywhere
                }
            }
        }

        RowLayout {
            Layout.leftMargin: 15
            Layout.rightMargin: 15
            Layout.topMargin: 5
            Layout.bottomMargin: 5

            Rectangle {
                Layout.fillWidth: true
                height: btn_send.height
                color: "#F4F2F5"
                border.color: "gray"
                border.width: 0

                TextInput {
                    id: msgToSend
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: 10
                    rightPadding: 10
                    width: parent.width
                    font.pixelSize: 14
                    clip: true
                }
            }


        }
    }



    function addMsg(someText)
    {
        return "[" + currentTime() + "] " + someText;
    }

    function currentTime()
    {
        var now = new Date();
        var nowString = ("0" + now.getHours()).slice(-2) + ":"
                + ("0" + now.getMinutes()).slice(-2) + ":"
                + ("0" + now.getSeconds()).slice(-2);
        return nowString;
    }


    Image {


            id: background
            x: 25
            y: 90
            width: 950
            height: 600


            }







    Rectangle {
        id: rectangle41
        x: 1
        y: 1


      width: 1
        height: 1
        color: "#3e3e7d"
        radius: 3
        border.color: "#3e3e7d"
        border.width: 3
    }


        TextInput {
            id: textInput
            x: 200+ 100
            y: 110+ 60
            width: 194
            height: 73
            color: "#5c6f7e"
            text: qsTr("NURSIE")
            font.pixelSize: 40
            font.family:  "Verdana"
            font.styleName: "Bold"
            font.weight: Font.DemiBold
        }


    Rectangle {
            id: rectangle1
            x: 1
            y: 1
            width: 1
            height: 1
            color: "white"
            radius: 20
            border.color: "#3e3e7d"
            border.width: 4

            TextInput {
                id: textInput1
                x: 1
                y:  1
                width: 1
                height: 1
                color: "#3e3e7d"
                text: qsTr("START/STOP ROBOT")
                font.pixelSize: 16
                font.styleName: "#000000"
            }


        }




    TextInput {
                id: patient
                x: 100+ 23
                y: 130+ 110
                width: 100
                height: 100
                color: "white"
                font.pixelSize: 24
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                selectedTextColor: "#663636"
                selectionColor: "#1a1a3a"
                onEditingFinished :
                {     if(patient.text === "1"  )
                    {


                         image1.source = "patients.png";

                    } else if (patient.text ==="2")

                    {

                         image1.source = "patient2.png";

                    } else

                    {
                        image1.source = "patients.png";
                    }

                }


            }



        Rectangle {
            id: rectangle3
            x: 1
            y:1
            width:1
            height: 1
            color: "#00ffffff"
            radius: 20
            border.color: "#beafaf"
            border.width: 4

            Text {
                id: text3
                x:  1
                y:  1
                width: 1
                height: 1
                color: "#3e3e7d"
                text: qsTr("STATUS")
                font.pixelSize: 1
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                styleColor: "#3e3e7d"
            }
            TextInput {
                id: textInput2
                x: 1
                y:  1
                width: 1
                height: 1
                color: "black"
                font.pixelSize: 16
                //text: qsTr("hi")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                selectedTextColor: "white"
                selectionColor: "white"
                onEditingFinished :
                {     if(textInput2.text === "0" || (textInput2.text === "1" ) || (textInput2.text === "2" ) || (textInput2.text === "3" ) ||(textInput2.text === "4" ))
                    {
                        red.color = "grey"
                         yellow.color = "grey"
                        green.color = "red"

                    } else if (textInput2.text <= "9" && (textInput2.text >= "5"))

                    {
                        yellow.color = "yellow"
                         red.color = "grey"
                        green.color = "grey"

                    } else

                    {
                        green.color = "grey"

                         yellow.color = "grey"
                        red.color = "green"
                    }

                }


            }



            Text {
                id: text4
                x:  0
                y:  30
                width: 1
                height: 1
                color: "#3e3e7d"
                text: qsTr("V")
                font.pixelSize: 1
                font.bold: true
            }

        Rectangle {
                id: red
                x:  1
                y: 1
                width: 1
                height: 1
                color: "grey"
                radius: width/2
            }
        Rectangle {
                id: yellow
                x:  1
                y:  1
                width: 1
                height: 1
                color: "grey"
                radius: width/2
            }
        Rectangle {
                id: green
                x:  1
                y:  1
                width: 1
                height: 1
                color: "grey"
                radius: width/2
            }


        }

        StateGroup {
            id: stateGroup
        }

        StateGroup {
            id: stateGroup1
            states: [

                State {
                    name: "LOGIN"
                    PropertyChanges {
                        target: text2
                        x:  420
                        y:  365
                        width: 72
                        height: 24
                        font.pixelSize: 22



                    }
                    PropertyChanges {
                        target: rectangle
                       color:"transparent"


                    }
                    PropertyChanges {
                        target: rectangle12
                       color:"transparent"


                    }
                    PropertyChanges {
                        target: RowLayout
                        x: 450
                        y:500

                    }
                    PropertyChanges {
                        target: rectangle7
                        color:"transparent"


                       // border.color: "white"
                        border.color: "#3e3e7d"
                        border.width: 3


                    }
                    PropertyChanges {
                        target: rectangle1
                        x: 170+ 190
                        y: 110+ 99
                        width: 280
                        height: 90
                        color: "white"
                        radius: 20
                        border.color: "#3e3e7d"
                        border.width: 4
                    }
                    PropertyChanges
                    {
                        target:background
                        source: "background.jpg"
                    }

                    PropertyChanges {
                        target: buttonlog
                        x: 1
                        y:1
                        width: 1
                        height: 1

                    }
                    PropertyChanges {
                        target: text4
                        x:  140
                                       y:  119
                                       width: 28
                                       height: 34

                                       font.pixelSize: 22
                    }
                    PropertyChanges {
                        target: red
                        x: 205
                        y: 60
                        width: 30
                        height: 30


                    }
                    PropertyChanges {
                        target: green
                        x: 205
                        y: 140
                        width: 30
                        height: 30


                    }
                    PropertyChanges {
                        target: yellow
                        x: 205
                        y: 100
                        width: 30
                        height: 30


                    }
                    PropertyChanges {
                        target: textInput

                        x: 410
                        y: 80+ 50
                        width: 194
                        height: 73

                    }

                        PropertyChanges {
                            target: textInput1
                            x:  170
                            y:  36
                            width: 1
                            height: 20
                            color: "#3e3e7d"
                            text: qsTr("START/STOP ROBOT")
                            font.pixelSize: 16
                            font.styleName: "#000000"
                        }
                        PropertyChanges {
                            target: rectangle41
                            x: 100+ 374
                                    y: 130+ 319
                                    width: 96
                                    height: 55
                                    color: "grey"
                        }
                        PropertyChanges {
                            target: image
                            x: 1
                            y: 1
                            width: 1
                            height: 1

                        }
                        PropertyChanges {
                            target:rectangle6
                             x :450
                            y: 520
                           height: 30
                            width: 60
                            color:"white"
                            border.color: "white"



                        }

                        PropertyChanges {
                            target: text12
                            x:  51
                            y:  15
                            width: 72
                            height: 24
                            font.pixelSize: 20

                        }
                        PropertyChanges {
                            target: rectangle3
                            x: 172+ 195
                            y: 130+ 220
                            width: 261
                            height: 240
                            color: "white"
                            border.color: "#3e3e7d"

                        }
                        PropertyChanges {
                            target: text3
                            x:  49
                                            y:  65
                                            width: 94
                                            height: 22
                                            color: "#3e3e7d"
                                            text: qsTr("STATUS")
                                            font.pixelSize: 22

                        }
                        PropertyChanges {
                            target: text21
                            x: 1
                            y: 1
                            width: 1
                            height: 1
                            font.pixelSize:1

                        }

                        PropertyChanges {
                            target: textInput2
                            x: 30
                                    y: 128
                                    width: 80
                                    height: 20


                        }

                        PropertyChanges {
                            target: textInput13
                           color : white
                           font.pixelSize: 1

                        }
                        PropertyChanges {
                            target: text31
                            x: 1
                            y: 1
                            width: 1
                            height: 1
                            font.pixelSize:1

                        }


                        PropertyChanges {
                            target: textInput31
                            x:  8
                            y:  10
                            width: 54
                            height: 22


                        }

                        PropertyChanges {
                            target:button
                                    x :550
                                    y: 220
                                    height: 64
                                    width: 64

                        }
                        PropertyChanges {
                            target: buttonText


                                        font.pointSize: 11
                                        font.styleName: "Bold"


                                    }



                       PropertyChanges {
                           target : button3
                           text : "See Data"

                                           x: 440
                                           y: 600
                                           width: 114
                                           height: 41
                       }


                       PropertyChanges {
                           target: textInput21
                           x: 1
                           y: 1
                           width: 1
                           height: 1
                           font.pixelSize:1

                       }



                }

                ,State {
                    name: "DATA2"
                    PropertyChanges
                    {
                        target:textP
                        x:  100
                        y: 100+ 60
                        width: 194
                        height: 73
                        color: "#5c6f7e"
                        font.pixelSize: 40
                    }

                    PropertyChanges
                    {
                        target:imageb
                        source: "white.jpg"
                    }

                    PropertyChanges
                    {
                        target:rectangle
                        x:1
                        y:1
                        width:0
                        height:0
                    }
                    PropertyChanges
                    {
                        target:rectangle12
                        x:1
                        y:1
                        width:0
                        height:0
                    }


                    PropertyChanges {
                        target: buttonText


                                    font.pointSize: 11
                                    font.styleName: "Bold"


                                }
                    PropertyChanges {
                        target:button
                                x :480
                                y: 240
                                height: 64
                                width: 64

                    }

                    PropertyChanges {
                        target: textInput

                        x: 100+ 200
                        y: 110+ 50
                        width: 194
                        height: 73

                    }
                    PropertyChanges {
                        target: buttonlog
                        x: 1
                        y:1
                        width: 1
                        height: 1

                    }
                    PropertyChanges {
                        target: text31
                        x: 1
                        y: 1
                        width: 1
                        height: 1
                        font.pixelSize:1


                    }
                    PropertyChanges {
                        target: text21
                        x: 1
                        y: 1
                        width: 1
                        height: 1
                        font.pixelSize:1

                    }
                    PropertyChanges {
                        target: image
                        x: 1
                        y: 1
                        width: 1
                        height: 1

                    }




                    PropertyChanges {
                        target: text6
                        x: 1
                        y: 1
                        width: 1
                        height: 1
                        color: "transparent"
                        font.pixelSize: 1
                        font.bold: false
                    }

                    PropertyChanges {
                        target: button5
                        x: 100+ 15
                        y: 130+ 438
                        width: 110
                        height: 34
                        text: qsTr("RETURN")

                    }
                    PropertyChanges {
                        target: button3
                        x: 100+ 1
                        y: 130+ 1
                        width: 0.1
                        height: 0.1
                        color:"transparent"


                    }
                    PropertyChanges {
                        target: button
                        x: 100+ 560
                        y: 130+ 30
                    }
                    PropertyChanges {
                        target: image1
                        x: 240
                        y: 130+ 101
                        width: 483
                        height: 321
                    }

                    PropertyChanges {
                        target: text6
                        x: 100+0.1
                        y: 130+0.1
                        width: 0.1
                        height: 0.1
                        color: "#282b39"
                        font.pointSize: 1
                        font.bold: true
                    }
                    PropertyChanges {
                        target: textInput13
                        x: 1
                        y: 1
                        width: 1
                        height: 1
                        font.pixelSize:1

                    }
                    PropertyChanges {
                        target: textInput21
                        x: 1
                        y: 1
                        width: 1
                        height: 1
                        font.pixelSize:1

                    }



                }
            ]
        }

        Rectangle {
            id: rectangle5
            x: 0
            y: 0
            width: 1
            height: 1
            color: "green"
            border.color: "#00000000"

        }

    Button {
                id: button3
                x: 1
                y: 1
                width: 1
                height: 1


                Connections {
                    target: button3
                    onClicked: stateGroup1.state = "DATA2"
                               //&& Qt.openUrlExternally("https://mail.google.com/mail/u/0/#inbox")

                }
            }
    Text {
            id: text6
            x: 1
            y: 1

            text: qsTr("SEE DATA")
            font.pixelSize: 1
            color: "#3e3e7d"
        }

    Rectangle {
        id: rectanglet
        x: 1
        y: 1
        width: 1
        height: 1
        color: "transparent"
        border.color: "#00000000"
    }



    Rectangle
        {
            id: button
            x :1
            y: 1
            height: 1
            width: 1
            color: "white"
            border.color: "#3e3e7d"
            border.width: 3
            radius: width/2

            Text {
                id: buttonText
                text: qsTr("START")
                color: "Green"
                anchors.centerIn: parent
                font.family:  fontOpenSans.name
                font.pointSize: 1
                font.styleName: "Bold"

            }

            MouseArea
            {
                anchors.fill: parent
                onPressed:
                {
                    if(buttonText.text === "START")
                    {
                        buttonText.text = "STOP"
                        buttonText.color = "red"
                        rectangle1.border.color = "red"
                        button.border.color = "red"
                        buttonText.font.styleName="Bold"


                        backend.sendClicked("on");
                    } else
                    {
                        buttonText.text = "START"
                        buttonText.color = "Green"
                        rectangle1.border.color = "green"
                        button.border.color = "green"
                        buttonText.font.styleName= "Bold"
                        backend.sendClicked("off");
                    }



                }

            }

        }




    Text {
        id: text2
        x:  1
        y:  1
        width: 0
        height: 0
        color: "#3e3e7d"
        text: qsTr("BATTERY LEVEL")
        font.pixelSize: 1
        font.bold: true
    }

    Rectangle {
        id: rectangle7
        x: 420
        y: 470
        width: 70
        height: 30
        color: "transparent"

    }

    Rectangle {
            id: rectangle6
            x: 1
            y: 1
            width: 1
            height: 1
            color: "black"
            radius: 3
            border.color: "#3e3e7d"
            border.width: 3

            TextInput {
                id: textInput31
                x:  1
                y:  1
                width: 1
                height: 1
                font.pixelSize: 12
                 horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                onEditingFinished :
                {     if(textInput31.text === "1"  )
                    {

                         image1.source = "patients.png";
                        backend.sendClicked("1");



                    } else if (textInput31.text === "2")

                    {

                         image1.source = "patient2.png";
                        backend.sendClicked("2");


                    } else if (textInput31.text === "3")

                    {
                        image1.source = "patient3.png";
                        backend.sendClicked("3");

                    }

                }
            }

        }
    RowLayout {
        x: 410
        y:540
                TextField {

                    id: messageInput
                    Layout.fillWidth: true
                    placeholderText: "Enter room number"
                    onEditingFinished :
                    {     if(messageInput.text === "1"  )
                        {

                             image1.source = "patients.png";
                            backend.sendClicked("1");

                        } else if (messageInput.text ==="2")

                        {

                             image1.source = "patient2.png";
                            backend.sendClicked("2");

                        } else if (messageInput.text ==="3")

                        {
                            image1.source = "patient3.png";
                            backend.sendClicked("3");
                        }

                    }




                }
                BetterButton {
                    text: "Send"

                    color: this.down ? "#6FA3D2" : "#7DB7E9"
                    border.color: "#6FA3D2"
                    onClicked: {
                        if (messageInput.text !== "") {
                            backend.sendMessageToClients(messageInput.text);
                            ti.append(addMsg("Sent message: " + messageInput.text));
                            messageInput.text = "";
                        }
                    }
                }
            }
    Image {
        id: image
        x: 25
        y: 90
        width: 950
        height: 600
        source: "4-hospital-hallway-allan-swart.jpg"
        fillMode: Image.PreserveAspectFit
    }
    Button {
        id: buttonlog
        x: 333+120
        y: 527+80
        width: 105
        height: 26
        text: qsTr("LOGIN")
        icon.color: "#7a3939"

            onClicked:
                if ((textInput13.text == "Yomna" && textInput21.text == "123") ){

                                stateGroup1.state = "LOGIN"
                                }


    }

    Rectangle {
        id: rectangle12
        x: 312+120
        y: 445+80
        width: 148
        height: 35
        color: "white"

        TextInput {
            id: textInput13
            x: 16
            y: 8
            width: 80
            height: 20


            font.pixelSize: 12
        }
    }


    Text {
        id: text31
        x: 240+120
        y: 496+80
        width: 95
        height: 25
        text: qsTr("PASSWORD")
        font.pixelSize: 12
        font.family: "Tahoma"
    }
    Text {
        id: text21
        x: 240+120
        y: 496+40
        width: 95
        height: 25
        text: qsTr("USERNAME")
        font.pixelSize: 12
        font.family: "Tahoma"
    }



    Rectangle {
        id: rectangle
        x: 312+120
        y: 486+80
        width: 148
        height: 35
        color: "white"

        TextInput {
            id: textInput3
            x: 13+90
            y: 8+90

            width: 80
            height: 20
            font.pixelSize: 12
        }
    }
    TextInput {
        id: textInput21//PASS
        x: 320+120
        y: 490+80
        width: 80
        height: 20

        font.pixelSize: 12


    }

    Image {
                id: imageb
                x: 25
                y: 90
                width: 950
                height: 600


            }
    Button {
            id: button5
            x: 1
            y: 1
            width: 1
            height: 1


            onClicked:


                stateGroup1.state = "LOGIN"



        }

    Text {
        id: textP
        x: 1
        y: 1
        width: 1
        height: 1
        text: qsTr("PATIENT DATA ")
        font.pixelSize: 1
        font.family: "Tahoma"
    }

    Image {
                id: image1
                x:  1
                y:  1
                width: 1
                height: 1

            }


}

