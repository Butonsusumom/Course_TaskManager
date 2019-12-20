import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

// Диалог подробного описания задания
Dialog {
    title: modelTask.get(tableView.currentRow).tasktitle + ""
    standardButtons: StandardButton.Ok


    function defval() {
        doneTask.checked = modelTask.get(tableView.currentRow).taskstatus === "Done" ? true : false
    }
    onAccepted: {
        database.updatestatus(modelTask.get(tableView.currentRow).id, doneTask.checked ? "Done" : "In process")
        database.updatedate(modelTask.get(tableView.currentRow).id, dateTask.text)
        database.updatetime(modelTask.get(tableView.currentRow).id, timeTask.text)
        modelTask.updateModel(Qt.formatDate(calendar.selectedDate, "yyyyMMdd"))
        if(calendar.style === newCalendarStyle) calendar.style = calendarstyle
        else calendar.style = newCalendarStyle
    }
    ColumnLayout {


        width: parent ? parent.width : 100


        CheckBox {
            id: doneTask
            Layout.fillWidth: true
            text: qsTr("Done")
        }
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Label {
                text: qsTr("Start:    ")
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
            }
            Label {
                Layout.alignment: Qt.AlignRight
                text: database.decodeDate(modelTask.get(tableView.currentRow).startdate)
                wrapMode: Text.WordWrap
            }
        }
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Label {
                text: qsTr("Deadline: ")
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
            }

            TextField{
                id:timeTask
                text: "<b>"+modelTask.get(tableView.currentRow).endtime+"</b> "
                inputMask: "99:99"
                inputMethodHints: Qt.ImhDigitsOnly
                validator: RegExpValidator { regExp: /^([0-1]?[0-9]|2[0-3]):([0-5][0-9])$ / }
                Layout.fillWidth: true
            }
            TextField{
                id:dateTask
                text: " <b>"+database.decodeDate(modelTask.get(tableView.currentRow).enddate)+"</b>"
                inputMask: "99-99-9999"
                inputMethodHints: Qt.ImhDigitsOnly
                validator: RegExpValidator { regExp: /^([0-2]?[0-9]|3[0-1])-(0?[0-9]|1[0-2])-([2-9][0-9][0-9][0-9])$ / }
                Layout.fillWidth: true
            }



           /* Label {
                text: "<b>"+modelTask.get(tableView.currentRow).endtime+"</b> "
                wrapMode: Text.WordWrap
            }
            Label {
                text: " <b>"+database.decodeDate(modelTask.get(tableView.currentRow).enddate)+"</b>"
                wrapMode: Text.WordWrap
            }*/
        }
        Label {
            text: modelTask.get(tableView.currentRow).taskdesc + ""
            Layout.fillWidth: true
            Layout.fillHeight: true
            y: 100
            wrapMode: Text.WordWrap
        }
    }
}
