import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0

Popup
{
    id: addPopup

    signal showKeyBoard();
    signal onSubmitClicked();
    signal addNameTextAreaData(string text);
    signal addChefNameTextAreaData(string text);
    signal addUrlTextAreaData(string text);

    function showData()
    {
        addPopup.visible = true
    }

    function nameAddText(text)
    {
        addNameTextAreaData(text);
    }

    function chefNameAddText(text)
    {
        addChefNameTextAreaData(text);
    }

    function urlAddText(text)
    {
        addUrlTextAreaData(text);
    }

    function addJsonData()
    {
        return {"name" : name.text,
            "chefName" : chefName.text,
            "url" : url.text}
    }

    function writeToServerFile(jsonString)
    {
        var xhr = new XMLHttpRequest();
        var url = "http://localhost:3021/students";
        var method = "POST";

        xhr.open(method, url, true);

        xhr.setRequestHeader("Content-Type", "application/json");

        xhr.send(jsonString);

        xhr.onreadystatechange = function ()
        {
            console.log(xhr.status)
            if (xhr.readyState === XMLHttpRequest.DONE)
            {
                if (xhr.status === 200)
                {
                    console.log("JSON data written to file on server successfully!");
                } else
                {
                    console.error("Failed to write JSON data to file on server!");
                }
            }
        };
    }

    visible: false
    closePolicy: "NoAutoClose"

    Rectangle
    {
        id: addPopupRect
        color: "black"
        anchors.fill: parent
        ColumnLayout
        {
            id:addPopupColumns
            anchors.fill:parent
            Rectangle
            {
                id:popupHeading
                Layout.preferredHeight: parent.height*0.15
                Layout.preferredWidth: parent.width*0.7
                anchors.horizontalCenter: parent.horizontalCenter
                color: "pink"
                Text
                {
                    id: popupText
                    anchors.centerIn: parent
                    text: qsTr("Add Items Here")
                    anchors.top: parent.top
                    color: "Black"
                }
            }

            Rectangle
            {
                id:closePopup
                height:parent.height*0.1
                width: parent.width*0.1
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
                        addPopup.visible = false
                    }
                }
            }

            AddTextArea {
                id: name
                Component.onCompleted: {
                    addPopup.addNameTextAreaData.connect(name.getText)
                    addPopup.onSubmitClicked.connect(textArea.textRemoved)
                    label = "Enter Item Name";
                }
            }

            AddTextArea {
                id: chefName
                Component.onCompleted: {
                    addPopup.addChefNameTextAreaData.connect(chefName.getText)
                    addPopup.onSubmitClicked.connect(chefName.textRemoved)
                    label = "Enter Chef Name";
                }
            }

            AddTextArea {
                id: url
                Component.onCompleted: {
                    addPopup.addUrlTextAreaData.connect(url.getText)
                    addPopup.onSubmitClicked.connect(url.textRemoved)
                    label = "Enter Url";
                }
            }






            Rectangle
            {
                id: submit
                Layout.preferredHeight: parent.height*0.1
                Layout.preferredWidth: parent.width*0.6
                anchors.horizontalCenter: parent.horizontalCenter
                color: "purple"
                opacity: 1
                Text
                {
                    id: submitText
                    text: qsTr("Submit")
                    anchors.centerIn: parent
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        if(name.text.trim() != "" && chefName.text.trim() !== "" && url.text.trim() !== "")
                        {
                            var jsonData = addJsonData();

                            var jsonString = JSON.stringify(jsonData);

                            writeToServerFile(jsonString);

                            addPopup.close();
                        } else
                        {
                            console.log("not filled")
                        }
                        onSubmitClicked();
                    }
                }
            }

        }
    }

}
