---
layout: post
title:  "Merging Excel Sheets"
tags: [excel]
---

I recently had to prepare some supplemental material for a publication where I had to combine all supplemental tables into one excel sheet. The idea was that each supplemental table would be in its own tab and labelled 1, 2, 3, etc. I started with 15 supplemental tables in separate excel files and after copying and pasting 2 tables manually into one excel sheet I lost patience and thought surely there was SOME WAY to do this automatically. 

After sourcing the internet, turns out there wasn't really any tutorial on how to do this. I ended up writing some visual basic code to do this:

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

To use this code, one needs to create a macro. For this to work, it requires one to create a new spreadsheet that holds all the merged spreadsheets.
