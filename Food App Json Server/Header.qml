import QtQuick 2.0
import QtQuick.Layouts 1.0

Rectangle
{
    id:header

    function headerColorChange(count)
    {
        if(count === 1)
        {
            header.color = "brown"
        } else
        {
            header.color = "pink"
        }
    }

    border.color: "black"
    border.width: 5

    RowLayout
    {
        id: headerRow
        height: header.height
        width: header.width
        Rectangle
        {
            id:headerRect
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.width
            color: "transparent"
            Image
            {
                id:headerImageLogo
                height: parent.height
                width: parent.height
                source: "file:/home/mansijangid/Downloads/FoodMainLogo-fotor-2023072020153.png"
            }
            Text
            {
                id: headerText
                anchors.centerIn: parent
                text: qsTr("Delicious Food Items")
            }
        }

    }

}
