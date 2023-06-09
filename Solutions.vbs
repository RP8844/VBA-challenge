Sub Ticker():

For Each ws In Worksheets

ws.Cells(1, 9).Value = "Ticker"
ws.Cells(1, 10).Value = "Yearly Change"
ws.Cells(1, 11).Value = "Percent Change"
ws.Cells(1, 12).Value = "Total Stock Volume"
ws.Cells(2, 15).Value = "Greatest % Increase"
ws.Cells(3, 15).Value = "Greatest % Decrease"
ws.Cells(4, 15).Value = "Greatest Total Volume"
ws.Cells(1, 16).Value = "Ticker"
ws.Cells(1, 17).Value = "Value"

  ' Set an initial variable for holding the Ticker
  Dim Ticker As String
  
  ' Set an initial variable for holding the Total Stock Volume
  Dim Total_Stock_Volume As Double
  
  ' Set the Open Price
  Dim Open_Price As Double

    ' Set the Close Price
    Dim Close_Price As Double
  
   ' Set Yearly Change
    Dim Yearly_Change As Double

    ' Set Percent Change
    Dim Percent_Change As Double
    
    ' Set Ticker Change
    Dim Ticker_Change As Double
    
    ' Set Start
    Dim Start As Double
    
    ' Set Change Price
    Dim Change_Price As Double
    
  ' Keep track of the location for each Ticker in the summary table
  Dim Summary_Table_Row As Double
  Summary_Table_Row = 2
  Total_Stock_Volume = 0
  j = 0
  Change_Price = 0
  Start = 2
    
  ' Loop through all Ticker
  lastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
For i = 2 To lastRow

    ' Check if we are still within the Ticker, if it is not
    If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
    Total_Stock_Volume = Total_Stock_Volume + ws.Cells(i, 7).Value
    
      ' Set the Ticker
      Ticker = ws.Cells(i, 1).Value
      
      ' Set the Percentage Format
       ws.Range("K" & Summary_Table_Row).Value = FormatPercent(ws.Range("K" & Summary_Table_Row))
       
      ' Print the Ticker in the Summary Table
      ws.Range("I" & Summary_Table_Row).Value = Ticker
      
      ' Print the Total Stock Value to the Summary Table
      ws.Range("L" & Summary_Table_Row).Value = Total_Stock_Volume
      
      ' Add one to the summary table row
      Open_Price = ws.Cells(Start, 3).Value
      Close_Price = ws.Cells(i, 6).Value
      Change_Price = Close_Price - Open_Price
      ws.Range("J" & Summary_Table_Row).Value = Change_Price
      Percent_Change = Change_Price / Open_Price
      ws.Range("K" & Summary_Table_Row).Value = Percent_Change
      Start = i + 1
      
      ' Set the Change: Positive Change is Green = 4 and Negative Change is Red = 3
      If ws.Range("J" & Summary_Table_Row).Value > 0 Then
      ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 4
      
      ElseIf ws.Range("J" & Summary_Table_Row).Value < 0 Then
      ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 3
      
      End If
      
      If ws.Range("K" & Summary_Table_Row).Value > 0 Then
      ws.Range("K" & Summary_Table_Row).Interior.ColorIndex = 4
      
      ElseIf ws.Range("K" & Summary_Table_Row).Value < 0 Then
      ws.Range("K" & Summary_Table_Row).Interior.ColorIndex = 3
      
      End If
      
        Summary_Table_Row = Summary_Table_Row + 1
      
       Total_Stock_Volume = 0
    
    Else
    
      ' Add to the Total Stock Volume
     Total_Stock_Volume = Total_Stock_Volume + ws.Cells(i, 7).Value
      
    End If
      
      Next i
    
      ws.Cells(2, 17).Value = WorksheetFunction.Max(ws.Range("K2:K" & Summary_Table_Row))
      ws.Cells(2, 16).Value = WorksheetFunction.Index(ws.Range("I2:I" & Summary_Table_Row), WorksheetFunction.Match(ws.Cells(2, 17).Value, ws.Range("K2:K" & Summary_Table_Row), 0))

      ws.Cells(3, 17).Value = WorksheetFunction.Min(ws.Range("K2:K" & Summary_Table_Row))
      ws.Cells(3, 16).Value = WorksheetFunction.Index(ws.Range("I2:I" & Summary_Table_Row), WorksheetFunction.Match(ws.Cells(3, 17).Value, ws.Range("K2:K" & Summary_Table_Row), 0))
   
      ws.Cells(4, 17).Value = WorksheetFunction.Max(ws.Range("L2:L" & Summary_Table_Row))
      ws.Cells(4, 16).Value = WorksheetFunction.Index(ws.Range("I2:I" & Summary_Table_Row), WorksheetFunction.Match(ws.Cells(4, 17).Value, ws.Range("L2:L" & Summary_Table_Row), 0))
            

Next ws

End Sub
