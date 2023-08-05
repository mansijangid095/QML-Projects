import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.4

RowLayout
{
    id: itemsRow

    property string text : nameTextInput.text
    property string label: "Enter Item Name";
    function textRemoved(){
        nameTextInput.text = "";
    }

    Layout.preferredHeight: parent.height
    Layout.preferredWidth: parent.width
    function getText(text) {
        if(nameTextInput.activeFocus == true)
            nameTextInput.text += text
    }

    Rectangle
    {
        id: name
        Layout.preferredHeight: parent.height*0.8
        Layout.preferredWidth: parent.width*0.5
        color: "gray"
        Text
        {
            id: nameText
            text: qsTr(label)
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        id:nameTextInputRect
        Layout.preferredHeight: parent.height*0.8
        Layout.preferredWidth: parent.width*0.5
        ScrollView
        {
            id:namescrollViewId
            anchors.fill: parent
            TextArea
            {
                id:nameTextInput
                anchors.fill:parent
                wrapMode: Text.NoWrap
                color:"black"
                cursorVisible: true
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        showKeyBoard();
                        nameTextInput.forceActiveFocus()

                    }
                    onFocusChanged: {
                        nameTextInput.focus = false
                    }
                }
            }

        }
    }
}
