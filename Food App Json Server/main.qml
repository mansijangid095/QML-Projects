import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

Window
{
    id:window
    width: 640
    height: 480
    visible: true
    title: qsTr("Assignment Week 3")

    ListView
    {
        id : listview

        signal getName(string name);
        signal getModelDataDescription(var text, var id, var url);
        signal showAddPopup();
        signal changeColor(int count);
        signal showKeyboardKeypad();
        signal showIndividualElements(var modelArray);
        signal showTextInAddData(string text);
        signal showTextInAddData2(string text);
        signal showTextInAddData3(string text);
        signal showIndividualElementsVisibility();

        function changeTheme(count)
        {
            if(count === 1)
            {
                window.color= "orange"
            } else
            {
                window.color= "white"
            }
        }
        function colorchanged(count)
        {
            listview.changeColor(count);
        }

        function getList(arr)
        {
            listview.model = arr;
            console.log(arr)
        }
        function showAddDataPopup()
        {
            showAddPopup();
        }

        function showkeypad()
        {
            showKeyboardKeypad();
        }
        function getIndividualElementsPopup(modelArray)
        {
            showIndividualElements(modelArray);
        }

        function getTextInAddData(text)
        {
            showTextInAddData(text);
        }
        function getTextInAddData2(text)
        {
            showTextInAddData2(text);
        }
        function getTextInAddData3(text)
        {
            showTextInAddData3(text);
        }
        function getElementsPopup()
        {
            showIndividualElementsVisibility();
        }

        anchors.fill: parent
        spacing:10
        highlight: highlightBar
        clip: true

        snapMode: ListView.SnapToItem

        header: Header
        {
            id: headerId
            color:  "pink"
            height: window.height*0.1
            width: window.width
            radius: 10
            z: 200
            Component.onCompleted:
            {
                listview.changeColor.connect(headerId.headerColorChange)
            }
        }
        footer: Footer
        {
            id: footerId
            color: "black"
            radius: 10
            height: window.height*0.1
            width: window.width
            z:2
            function showPopup()
            {
                listview.showAddPopup();
            }

            Component.onCompleted:
            {
                footerId.getList.connect(listview.getList)
                footerId.showAddDataPopup.connect(footerId.showPopup)
                footerId.changeTheme.connect(listview.changeTheme)
                footerId.changeTheme.connect(footerId.footerColorChange)
                footerId.changeTheme.connect(listview.colorchanged)
            }
        }

        delegate: Delegate
        {
            id: delegateRectId
            color: "gray"
            height: window.height*0.1
            width: window.width
            delegateData: modelData.name
            radius: 20
            Component.onCompleted:
            {
                listview.getName.connect(delegateRectId.getTitle)
                listview.getModelDataDescription.connect(popupId.getText)
                listview.changeColor.connect(delegateRectId.changeColor)
            }
            MouseArea
            {
                anchors.fill: parent
                z:3
                onClicked:
                {
                    popupId.visible = true
                    var text = "name : " + modelData.name.name + "\n" +
                            "ChefName : " + modelData.name.chefName

                    listview.getModelDataDescription(text, modelData.name.id, modelData.name.url)
                }
            }
        }
        DescriptionPopup
        {
            id: popupId
            height: window.height*0.5
            width: window.width*0.5
        }
        AddDataPopUp
        {
            id: addDataPoppupId
            height: window.height*0.5
            width: window.width*0.5
            Component.onCompleted:
            {
                listview.showAddPopup.connect(addDataPoppupId.showData)
                addDataPoppupId.showKeyBoard.connect(listview.showkeypad)
                listview.showTextInAddData.connect(addDataPoppupId.nameAddText)
                listview.showTextInAddData2.connect(addDataPoppupId.chefNameAddText)
                listview.showTextInAddData3.connect(addDataPoppupId.urlAddText)
            }
            z:3
            x: window.width - addDataPoppupId.width

        }
        Keypad
        {
            id: keyboard
            height: parent.height*0.7
            border.color: "black"
            Component.onCompleted:
            {
                listview.showKeyboardKeypad.connect(keyboard.getVisible)
                keyboard.getNewWindow.connect(listview.getIndividualElementsPopup)
                listview.showIndividualElementsVisibility.connect(keyboard.focusKeyBoard)
            }
            z:2
        }
        SubModuleKeyboard
        {
            id: subModuleKeyboard
            Component.onCompleted:
            {
                listview.showIndividualElements.connect(subModuleKeyboard.getModel)
                subModuleKeyboard.appendElementInTextArea.connect(listview.getTextInAddData)
                subModuleKeyboard.appendElementInTextArea.connect(listview.getTextInAddData2)
                subModuleKeyboard.appendElementInTextArea.connect(listview.getTextInAddData3)
                subModuleKeyboard.keyBoardFocus.connect(listview.getElementsPopup)
            }
            z:1
        }

        footerPositioning: ListView.OverlayFooter
        headerPositioning: ListView.OverlayHeader
    }

}
