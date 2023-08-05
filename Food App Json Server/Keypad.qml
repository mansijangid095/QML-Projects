import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.4

Rectangle
{
    id: mainKeyboard

    property var smallAlphabets: ["abc", "def", "gji", "jkl", "mno", "pqr", "stu", "vwx", "yz"]
    property var capitalAlphabets: ["ABC", "DEF", "GHI", "JKL", "MNO", "PQR", "STU", "VWX", "YZ"]
    property var numbers: ["1", "2", "3", "4", "5", "6", "7", "8", "9 0"]
    property var specialCharacters: ["!@#", " $%^", "&*(", "-(=",";:/","<>.",".\|", "+}{","[]`"]

    signal printElementIntextInput(string text);
    signal printSpace(string text);
    signal actionBackSpace();
    signal buttonsValues(int count);
    signal shiftCursorright();
    signal shiftCursorleft();
    signal submitValues();
    signal getNewWindow(var modelArray);

    function changeButtonsValues(count)
    {
        if(count === 0) {
            buttonsGridRepeater.model = smallAlphabets
        } else if(count === 1)
        {
            buttonsGridRepeater.model = capitalAlphabets
        } else if(count === 2)
        {
            buttonsGridRepeater.model = numbers
        } else if(count === 3)
        {
            buttonsGridRepeater.model = specialCharacters
        }
    }

    function focusKeyBoard()
    {
        mainKeyboard.opacity = 1;
        mainKeyboard.enabled = true
    }
    function getVisible()
    {
        mainKeyboard.visible = true
    }

    height: 250
    width:300
    visible: false

    Rectangle
    {
        id:closePopup
        height:parent.height*0.1
        width: parent.height*0.1
        color: "red"
        Text
        {
            id: close
            text: qsTr("X")
            anchors.centerIn: parent
        }
        anchors.right: parent.right
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                mainKeyboard.visible = false

            }
        }
    }
    GridLayout
    {
        id: characters
        y: 60
        rowSpacing: 20
        columnSpacing: 30
        columns: 3
        rows: 3
        visible: true
        Repeater
        {
            id: buttonsGridRepeater
            model:smallAlphabets
            delegate: Rectangle
            {
                width: 77
                height:30
                color:"black"
                radius: 5
                Text
                {
                    id: textkeyboard
                    text:modelData
                    anchors.centerIn: parent
                    color:"white"
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        individualelements.visible = true
                        var modelArray =[]
                        for(var i=0;i<modelData.length;i++)
                        {
                            modelArray[i] = modelData[i]
                        }
                        getNewWindow(modelArray);
                        mainKeyboard.opacity = 0.5
                        mainKeyboard.enabled = false

                    }
                    onDoubleClicked:
                    {

                        mainKeyboard.opacity = 1
                        mainKeyboard.enabled = true
                    }
                }
            }

        }
    }

    Row
    {
        id: individualelements
        x: 0
        y: 10
        spacing: 20
        visible: false
        Repeater
        {
            id: repeaterid
            delegate: Rectangle
            {
                id:element
                width: 65
                height: 35
                color: "green"
                radius: 5
                Text
                {
                    id: elementData
                    anchors.centerIn: parent
                    text: modelData

                }

                MouseArea
                {
                    anchors.fill:parent
                    onClicked:
                    {
                        printElementIntextInput(elementData.text)
                    }
                }
            }
        }
    }

    Row
    {
        id: buttons
        x: 0
        y: 230
        spacing: 12
        Rectangle
        {
            id:leftShift
            height: 30
            width:65
            color:"yellow"
            radius: 5
            border.color: "black"
            Text
            {
                id:leftShiftText
                text:"<"
                font.bold : true
                anchors.centerIn: parent
            }

            MouseArea
            {
                anchors.fill:parent
                onClicked: {
                    shiftCursorleft();
                }
            }
        }
        Rectangle
        {
            id:rightShift
            height: 30
            width: 65
            color: "yellow"
            radius: 5
            border.color: "black"
            Text
            {
                id:rightShiftText
                text: ">"
                anchors.centerIn: parent
                font.bold : true
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    shiftCursorright();
                }
            }
        }
        Rectangle
        {
            id:space
            height: 30
            width: 65
            color:  "yellow"
            radius: 5
            border.color: "black"
            Text
            {
                id:spaceText
                text: "Space"
                anchors.centerIn: parent
                font.bold : true
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    printElementIntextInput(" ");
                }
            }
        }
        Rectangle
        {
            id: changeInput
            height: 30
            width: 60
            color: "yellow"
            radius: 5
            border.color: "black"
            Text
            {
                id:changeInputText
                text: "-->"
                font.bold : true
                anchors.centerIn: parent

            }
            MouseArea
            {
                anchors.fill: parent
                property  int count: 0
                onClicked: {
                    changeButtonsValues(count);
                    if(count < 3) {
                        count++;
                    } else {
                        count=0
                    }
                }
            }
        }
    }
    Row
    {
        id: buttons2
        x: 0
        y: 280
        spacing : 30
        Rectangle
        {
            id:enter
            height: 30
            width: 70
            color: "yellow"
            radius: 5
            border.color: "black"
            Text
            {
                id: enterText
                text: "Enter"
                anchors.centerIn: parent
                font.bold : true

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        printElementIntextInput("\n");
                    }
                }
            }
        }


        Rectangle
        {
            id:backSpace
            height: 30
            width: 90
            color: "yellow"
            radius: 5
            border.color: "black"
            Text
            {
                id:backSpaceText
                text: "BackSpace"
                anchors.centerIn: parent
                font.bold : true

                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        actionBackSpace();

                    }
                }
            }
        }

        Rectangle
        {
            id: submit
            height: 30
            width: 70
            color: "yellow"
            radius: 5
            border.color: "black"
            Text
            {
                id:submitText
                text: "Submit"
                anchors.centerIn: parent
                font.bold : true

                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        submitValues();
                        characters.visible = false
                        buttons.visible = false
                        buttons2.visible = false
                    }
                }
            }
        }
    }
    Rectangle
    {
        id:reset
        x: 130
        y: 10
        height:30
        width: 30
        color: "red"
        radius: 20
        border.color: "black"
        Text
        {
            id: resetText
            text: "^"
            anchors.centerIn: parent
            font.bold : true
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                characters.visible = true
                buttons.visible = true
                buttons2.visible = true
            }
        }
    }




}
