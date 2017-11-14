import QtQuick 2.9
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

ApplicationWindow {
    id: root
    visible: true
    width: Screen.width/2
    x: Screen.width/2
    height: 300
    title: qsTr("Piano")
    color: "grey"
    property int foo:60;
    function getRandomInt(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min)) + min; //The maximum is exclusive and the minimum is inclusive
    }
    Timer {
        id: randomTimer
        interval: 5000
        running: true
        repeat: true
        onTriggered: {

            foo=getRandomInt(60,73);

            //console.log("===========>"+foo+generatedText.text)
            noteToGuess.visible=true;
            noteToGuess.state="initial";

            if(foo===60){
                generatedText.text = "C4(60)";
                noteToGuess.y=(root.height/2)-10;
            } else if(foo===61) {
                generatedText.text = "C4#(61)";
                noteToGuess.y=(root.height/2)-10
            } else if(foo===62) {
                generatedText.text = "D4(62)";
                noteToGuess.y=(root.height/2)-20
            } else if(foo===63) {
                generatedText.text = "Eb4(63)";
                noteToGuess.y=(root.height/2)-30
            } else if(foo===64) {
                generatedText.text = "E4(64)";
                noteToGuess.y=(root.height/2)-30
            } else if(foo===65) {
                generatedText.text = "F4(65)";
                noteToGuess.y=(root.height/2)-40
            } else if(foo===66) {
                generatedText.text = "F4#(66)";
                noteToGuess.y=(root.height/2)-40
            } else if(foo===67) {
                generatedText.text = "G4(67)";
                noteToGuess.y=(root.height/2)-50
            } else if(foo===68) {
                generatedText.text = "Ab4(68)";
                noteToGuess.y=(root.height/2)-60
            } else if(foo===69) {
                generatedText.text = "A4(69)";
                noteToGuess.y=(root.height/2)-60
            } else if(foo===70) {
                generatedText.text = "Hb4(70)";
                noteToGuess.y=(root.height/2)-70
            } else if(foo===71) {
                generatedText.text = "H4(71)";
                noteToGuess.y=(root.height/2)-70
            } else if(foo===72) {
                generatedText.text = "C5(72)";
                noteToGuess.y=(root.height/2)-80
            } else {
                generatedText.text = "";
                noteToGuess.y=0;
            }
            noteToGuess.state="final";
        }
    }
    Connections{
        target: $piano
        onSendNote: {
            if(type==="OFF"){
                noteText.text = "";
                noteRect.visible=false;
                noteRect.y=0;
                status.text="";
                return;
            }

            if(note==="60"){
                noteText.text = "C4(60)";
                noteRect.visible=true;
                noteRect.y=(root.height/2)-10
            } else if(note==="61") {
                noteText.text = "C4#(61)";
                noteRect.visible=true;
                noteRect.y=(root.height/2)-10
            } else if(note==="62") {
                noteText.text = "D4(62)";
                noteRect.visible=true;
                noteRect.y=(root.height/2)-20
            } else if(note==="63") {
                noteText.text = "Eb4(63)";
                noteRect.visible=true;
                noteRect.y=(root.height/2)-30
            } else if(note==="64") {
                noteText.text = "E4(64)";
                noteRect.visible=true;
                noteRect.y=(root.height/2)-30
            } else if(note==="65") {
                noteText.text = "F4(65)";
                noteRect.visible=true;
                noteRect.y=(root.height/2)-40
            } else if(note==="66") {
                noteText.text = "F4#(66)";
                noteRect.visible=true;
                noteRect.y=(root.height/2)-40
            } else if(note==="67") {
                noteText.text = "G4(67)";
                noteRect.visible=true;
                noteRect.y=(root.height/2)-50
            } else if(note==="68") {
                noteText.text = "Ab4(68)";
                noteRect.visible=true;
                noteRect.y=(root.height/2)-60
            } else if(note==="69") {
                noteText.text = "A4(69)";
                noteRect.visible=true;
                noteRect.y=(root.height/2)-60
            } else if(note==="70") {
                noteText.text = "Hb4(70)";
                noteRect.visible=true;
                noteRect.y=(root.height/2)-70
            } else if(note==="71") {
                noteText.text = "H4(71)";
                noteRect.visible=true;
                noteRect.y=(root.height/2)-70
            } else if(note==="72") {
                noteText.text = "C5(72)";
                noteRect.visible=true;
                noteRect.y=(root.height/2)-80
            } else {
                noteText.text = "";
                noteRect.visible=false;;
                noteRect.y=0;
            }

            if(note===foo.toString()){
                status.text="YEAH!";
                noteToGuess.state="initial"
            } else {
                status.text="Booooo!";
            }

            console.log("displayNote:"+noteText.text)
        }
    }
    Rectangle {
        id: noteRect
        height: 20

        width: 20
        x: parent.width/5
        visible: false
        color: "black"
        radius: width*0.5

    }
    Rectangle {
        id: noteToGuess
        height: 20
        width: 20
        x: parent.width*4/5
        visible: false
        color: "black"
        radius: width*0.5
        transitions: [
            Transition {
                from: "initial"
                to: "final"
                PropertyAnimation { target: noteToGuess; properties: "x";
                    duration: 4000; }
            }
        ]
        states: [
            State {
                name: "initial"
                PropertyChanges {
                    target: noteToGuess; x: root.width*4/5
                }
            },
            State {
                name: "final"
                PropertyChanges {
                    target: noteToGuess; x: root.width/5

                }
            }
        ]
    }

    Text {
        id: generatedText
        text: ""
        font.pixelSize: 20
        anchors.bottom: parent.bottom
        x: parent.width*4/5
    }
    Text {
        id: status
        text: qsTr("Status: ")
        font.pixelSize: 30
        anchors.right: parent.right
    }

    Text {
        id: noteText
        text: ""//qsTr("bar")
        anchors.bottom: parent.bottom
        x: parent.width/5
        font.pixelSize: 20
    }

    Rectangle {
        y: (parent.height/2)-100
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        height: 1
        color: "black"
    }
    Rectangle {
        y: (parent.height/2)-80
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        height: 1
        color: "black"
    }
    Rectangle {
        y: (parent.height/2)-60
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        height: 1
        color: "black"
    }
    Rectangle {
        y: (parent.height/2)-40
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        height: 1
        color: "black"
    }
    Rectangle {
        y: (parent.height/2)-20
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        height: 1
        color: "black"
    }
    //C4, middle C
    Rectangle {
        y: parent.height/2
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        height: 1
        color: "white"
    }
    //    Rectangle {
    //        y: (parent.height/2)+20
    //        anchors.left: parent.left;
    //        anchors.right: parent.right;
    //        anchors.leftMargin: 10
    //        anchors.rightMargin: 10
    //        height: 1
    //        color: "black"
    //    }
    //    Rectangle {
    //        y: (parent.height/2)+40
    //        anchors.left: parent.left;
    //        anchors.right: parent.right;
    //        anchors.leftMargin: 10
    //        anchors.rightMargin: 10
    //        height: 1
    //        color: "black"
    //    }
    //    Rectangle {
    //        y: (parent.height/2)+60
    //        anchors.left: parent.left;
    //        anchors.right: parent.right;
    //        anchors.leftMargin: 10
    //        anchors.rightMargin: 10
    //        height: 1
    //        color: "black"
    //    }
    //    Rectangle {
    //        y: (parent.height/2)+80
    //        anchors.left: parent.left;
    //        anchors.right: parent.right;
    //        anchors.leftMargin: 10
    //        anchors.rightMargin: 10
    //        height: 1
    //        color: "black"
    //    }
    //    Rectangle {
    //        y: (parent.height/2)+100
    //        anchors.left: parent.left;
    //        anchors.right: parent.right;
    //        anchors.leftMargin: 10
    //        anchors.rightMargin: 10
    //        height: 1
    //        color: "black"
    //    }

    MouseArea {
        anchors.fill: parent
        onClicked: Qt.quit();
    }
}
