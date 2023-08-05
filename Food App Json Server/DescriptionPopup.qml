import QtQuick 2.0
import QtQuick.Controls 2.4

Popup
{
    id:popup

    function getText(text, id,url)
    {
        descriptionRectangleText.text = text
        removeItem.removeItem = id
        popupImage.source = url
    }

    function deleteDataOnServer(index)
    {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function()
        {
            if (xhr.readyState === XMLHttpRequest.DONE)
            {
                if (xhr.status === 200)
                {
                    console.log("Data deleted successfully!");

                } else
                {
                    console.error("Failed to delete data: " + xhr.status + " - " + xhr.statusText);
                }
            }
        }



        xhr.open("DELETE", "http://localhost:3021/students/" +index);
        xhr.send();
    }

    visible: false
    anchors.centerIn: parent


    Rectangle
    {
        id: closePopup
        color: "red"
        height: parent.height*0.1
        width: parent.height*0.1
        anchors.right: parent.right
        anchors.top: parent.top
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                popup.visible = false
            }
        }
        Text
        {
            id: closePopupText
            text: qsTr("X")
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        id: removeItem
        height: parent.height*0.15
        width: parent.width
        color: "purple"
        anchors.bottom: parent.bottom
        property var removeItem;
        Text
        {
            id: removeItemText
            text: qsTr("Remove Item")
            anchors.centerIn: parent
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                deleteDataOnServer(removeItem.removeItem)
                popup.close();
            }
        }
    }

    Text
    {
        id: popupText
        anchors.centerIn:parent
    }
    Rectangle
    {
        id: description
        height: parent.height*0.4
        anchors.centerIn: parent
        anchors.topMargin: 50
        width: parent.width*0.7

        z:2
        color: "transparent"
        ScrollView
        {
            anchors.fill:parent

            TextArea
            {
                id: descriptionRectangleText
                anchors.fill: parent
                readOnly: true
                anchors.centerIn: parent
                text: popupText.text
                wrapMode: Text.WordWrap
            }
        }
    }

    Image
    {
        id: popupImage
        height: parent.height*0.3
        width: parent.height*0.3
    }
}
