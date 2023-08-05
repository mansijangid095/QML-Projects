import QtQuick 2.0

Rectangle
{
    id:delegateRectangle

    property var delegateData;

    function getTitle(name)
    {
        console.log(name)
    }

    function changeColor(count)
    {
        if(count === 1)
        {
            delegateRectangle.color = "pink"
        } else
        {
            delegateRectangle.color = "gray"
        }
    }


    border.color: "black"
    border.width: 2


    Image
    {
        id:titleImage
        height: parent.height
        width: parent.height
        source:delegateData.url
    }

    Text
    {
        id: titleText
        text : delegateData.name
        anchors.centerIn: parent
    }
}
