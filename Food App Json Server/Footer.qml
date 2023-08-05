import QtQuick 2.0
import QtQuick.Layouts 1.0

Rectangle
{
    id:footer

    signal showAddDataPopup();
    signal changeTheme(int count);
    signal getModelDataTitle(string name);
    signal getList(var list);
    signal showMainWindow();

    function fetchJsonData(url, callback)
    {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function ()
        {
            if(xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED)
            {
                print("HEADERS RECIEVED");
            } else if(xhr.readyState === XMLHttpRequest.DONE)
            {
                print('DONE');
                console.log(xhr.status)
                if(xhr.status === 200)
                {
                    console.log("resource found")
                    callback(xhr.responseText.toString())
                } else
                {
                    callback(null)
                }
            }
        }

        xhr.open("GET", url);
        xhr.send();
    }

    function footerColorChange(count)
    {
        if(count === 1)
        {
            footer.color = "green"
        } else
        {
            footer.color = "black"
        }
    }

    RowLayout
    {
        height: footer.height
        width: footer.width
        Rectangle
        {
            id:refresh
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.width*0.33
            color: "transparent"
            Image
            {
                id:refreshImage
                height: parent.height
                width: parent.height
                source: "file:/home/mansijangid/Downloads/refresh.png"
                MouseArea
                {
                    anchors.fill: parent

                    onClicked:
                    {
                        var mData = []
                        fetchJsonData("http://localhost:3021/students",
                                      function(response)
                                      {

                                          if(response)
                                          {

                                              var object = JSON.parse(response)

                                              for(var i=0;i<object.length;i++)
                                              {
                                                  mData.push({"name" : object[i]});
                                                  getModelDataTitle(object[i].name);
                                              }
                                          } else
                                          {
                                              console.log("something went wrong")
                                          }
                                          for(var j=0;j<mData.length;j++)
                                          {
                                              console.log(mData[j])
                                          }
                                          getList(mData);

                                      });
                    }

                }

            }



        }
        Rectangle
        {
            id:addIcon
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.width*0.32
            color: "transparent"
            property var jsonData;
            Image
            {
                id:addIconImage
                height: parent.height
                width: parent.height
                anchors.centerIn: parent
                source: "file:/home/mansijangid/Downloads/addIcon.png"
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        showAddDataPopup();
                    }
                }
            }

        }
        Rectangle
        {
            id:changeThemeRect
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.width*0.33
            color: "transparent"
            Image
            {
                id:changeThemeImage
                height: parent.height
                width: parent.height
                anchors.right: parent.right
                anchors.rightMargin: 4
                source: "file:/home/mansijangid/Downloads/changeTheme.jpeg"
                MouseArea
                {
                    anchors.fill: parent
                    property int count : 1;
                    onClicked: {
                        changeTheme(count);
                        count = count%2
                        count++
                    }
                }
            }

        }
    }
    Component.onCompleted:
    {
        var mData = []
        fetchJsonData("http://localhost:3021/students",
                      function(response)
                      {
                          if(response)
                          {
                              var object = JSON.parse(response)
                              for(var i=0;i< object.length;i++)
                              {
                                  mData.push({"name" : object[i]});
                                  console.log(object[i].name)
                                  getModelDataTitle(object[i].name);
                              }
                          } else
                          {
                              console.log("something went wrong")
                          }
                          for(var j=0;j<mData.length;j++)
                          {
                              console.log(mData[j])
                          }
                          getList(mData);
                      });
    }
}


