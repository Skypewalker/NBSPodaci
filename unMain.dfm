object Form1: TForm1
  Left = 526
  Top = 157
  Width = 529
  Height = 280
  Caption = 'NBS Pretraga'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 36
    Width = 35
    Height = 16
    Caption = 'Naziv:'
  end
  object Label2: TLabel
    Left = 8
    Top = 60
    Width = 45
    Height = 16
    Caption = 'Adresa:'
  end
  object Label3: TLabel
    Left = 8
    Top = 84
    Width = 41
    Height = 16
    Caption = 'Ra'#269'un:'
  end
  object Label4: TLabel
    Left = 8
    Top = 108
    Width = 40
    Height = 16
    Caption = 'Mesto:'
  end
  object Label5: TLabel
    Left = 8
    Top = 132
    Width = 42
    Height = 16
    Caption = 'Status:'
  end
  object Label6: TLabel
    Left = 8
    Top = 156
    Width = 49
    Height = 16
    Caption = 'Op'#353'tina:'
  end
  object Label7: TLabel
    Left = 8
    Top = 180
    Width = 59
    Height = 16
    Caption = 'Delatnost:'
  end
  object Label8: TLabel
    Left = 8
    Top = 204
    Width = 25
    Height = 16
    Caption = 'PIB:'
  end
  object Label9: TLabel
    Left = 8
    Top = 12
    Width = 24
    Height = 16
    Caption = 'MB:'
  end
  object Button1: TButton
    Left = 296
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Tra'#382'i'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object txtNaziv: TEdit
    Left = 80
    Top = 32
    Width = 401
    Height = 24
    TabOrder = 1
  end
  object txtAdresa: TEdit
    Left = 80
    Top = 56
    Width = 401
    Height = 24
    TabOrder = 2
  end
  object txtRacun: TEdit
    Left = 80
    Top = 80
    Width = 401
    Height = 24
    TabOrder = 3
  end
  object txtMesto: TEdit
    Left = 80
    Top = 104
    Width = 401
    Height = 24
    TabOrder = 4
  end
  object txtStatus: TEdit
    Left = 80
    Top = 128
    Width = 401
    Height = 24
    TabOrder = 5
  end
  object txtOpstina: TEdit
    Left = 80
    Top = 152
    Width = 401
    Height = 24
    TabOrder = 6
  end
  object txtDelatnost: TEdit
    Left = 80
    Top = 176
    Width = 401
    Height = 24
    TabOrder = 7
  end
  object txtPIB: TEdit
    Left = 80
    Top = 200
    Width = 200
    Height = 24
    TabOrder = 8
  end
  object txtMB: TEdit
    Left = 80
    Top = 8
    Width = 200
    Height = 24
    TabOrder = 9
    Text = '20175095'
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 656
    Top = 48
  end
end
