import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0

Popup
{
    id: keysPopup

    signal keyBoardFocus();
    signal appendElementInTextArea(string text);

    function getModel(modelArray)
    {
        repeaterid.model = modelArray;
        keysPopup.visible = true
    }


    height: 200
    width: 250
    visible: false
    x: 25;
    y:130;
    closePolicy: "NoAutoClose"

    Rectangle
    {
        x: 200
        y:0
        height: 30
        width: 30
        color: "red"
        Text
        {
            id: closepopup
            text: "X"
            font.bold: true
            anchors.centerIn: parent
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                keysPopup.visible = false;
                keyBoardFocus();
            }
        }
    }

    Row
    {
        id: individualelements
        anchors.centerIn: parent
        x: 0
        y: 40
        spacing: 20
        visible: true
        Repeater
        {
            id: repeaterid
            delegate: Rectangle
            {
                width: 60
                height: 55
                color: "green"
                border.color: "black"
                radius: 5
                Text
                {
                    id: elementData
                    anchors.centerIn: parent
                    text: modelData
                    font.bold : true
                    color: "white"
                }

                MouseArea
                {
                    anchors.fill:parent
                    onClicked:
                    {
                        appendElementInTextArea(elementData.text);
                    }
                }
            }

        }
    }
}
