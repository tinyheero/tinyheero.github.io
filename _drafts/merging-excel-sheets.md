---
layout: post
title:  "Merging Excel Sheets"
tags: [excel]
---

I recently had to prepare some supplemental material for a publication where I had to combine numerous supplemental tables in different excel workbooks into one master excel workbook. The idea was that each supplemental table would be in its own tab and labelled 1, 2, 3, etc. I started doing it manually and thought surely there was SOME WAY to do this automatically. 

After scouring the internet, turns out there wasn't really any tutorial on how to do this. The solution I settled on was using visual basic code. I have created a github repository that demonstrates how to do this



```
Function toArray(col As Collection)

 Dim arr() As String
 ReDim arr(1 To col.Count) As String
  For i = 1 To col.Count
      arr(i) = col(i)
  Next
  toArray = arr
End Function

Sub GetSheets()

Dim ws As Worksheet
Application.DisplayAlerts = False
For Each ws In Worksheets
If ws.Name <> "Sheet1" Then ws.Delete
Next
Application.DisplayAlerts = True

Dim col As New Collection
Dim element As Variant

Dim FileNum As Integer
Dim DataLine As String

listoftablesfile = Dir(Path & "list-of-tables.txt")
FileNum = FreeFile()
Open listoftablesfile For Input As #FileNum

While Not EOF(FileNum)
    Line Input #FileNum, tablefile ' read in data 1 line at a time
    col.Add Dir(Path & tablefile) ' dynamically add value to the end
Wend

workbookArray = toArray(col) ' convert collection to an array

For i = LBound(workbookArray) To UBound(workbookArray)

  element = workbookArray(i)
  workbooks.Open Filename:=Path & element, ReadOnly:=True
  
  For Each Sheet In ActiveWorkbook.Sheets
    Sheet.Copy After:=ThisWorkbook.Sheets(ThisWorkbook.Sheets.Count)
    ActiveSheet.Name = i
     
    Next Sheet
      workbooks(element).Close savechanges:=False
     
    Next i

End Sub
```

To use this code:

1. Create a new spreadsheet that will hold all the merged spreadsheets.
1. In the new spreadsheet, go to the "Developer"  tab and choose Editor. Then right click and choose "Insert -> Module".
1. This should open a window where you can copy and paste the above code.
1. In the same folder, create a list-of-tables.txt file. This file should contain the path to each individual supplemental table you want to merge in

## How it Works

