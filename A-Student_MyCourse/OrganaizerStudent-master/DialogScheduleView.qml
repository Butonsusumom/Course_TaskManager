import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

// Диалог подробного описания строки рассписания
Dialog {
    title: modelSchedule.get(tableSchedule.currentRow).schedultitle + ""
    standardButtons: StandardButton.Ok
    onAccepted: {
    database.updateend(modelSchedule.get(tableSchedule.currentRow).id, schedulend.text)
    database.updatestart(modelSchedule.get(tableSchedule.currentRow).id, schedulstart.text)
    modelSchedule.updateModel(Qt.formatDate(calendar.selectedDate, "yyyyMMdd"))
        if(calendar.style === newCalendarStyle) calendar.style = calendarstyle
        else calendar.style = newCalendarStyle
    }

    ColumnLayout {
        width: parent ? parent.width : 100
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Label {
                text: qsTr("Start: ")
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
            }
           /* Label {
                Layout.alignment: Qt.AlignRight
                text: modelSchedule.get(tableSchedule.currentRow).schedulstart + ""
                wrapMode: Text.WordWrap
            }*/

            TextField{
                id: schedulstart
                text: "<b>"+modelSchedule.get(tableSchedule.currentRow).schedulstart +"</b> "
                inputMask: "99:99"
                inputMethodHints: Qt.ImhDigitsOnly
                validator: RegExpValidator { regExp: /^([0-1]?[0-9]|2[0-3]):([0-5][0-9])$ / }
                Layout.fillWidth: true
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Label {
                text: qsTr("End:  ")
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
            }
            /*Label {
                text: modelSchedule.get(tableSchedule.currentRow).schedulend + ""
                wrapMode: Text.WordWrap
            }*/


            TextField{
                id:schedulend
                text: ""+modelSchedule.get(tableSchedule.currentRow).schedulend +""
                inputMask: "99:99"
                inputMethodHints: Qt.ImhDigitsOnly
                validator: RegExpValidator { regExp: /^([0-1]?[0-9]|2[0-3]):([0-5][0-9])$ / }
                Layout.fillWidth: true
            }
        }
        Label {
            text: modelSchedule.get(tableSchedule.currentRow).scheduldesc + ""
            Layout.fillWidth: true
            Layout.fillHeight: true
            y: 100
            wrapMode: Text.WordWrap
        }
    }
}
