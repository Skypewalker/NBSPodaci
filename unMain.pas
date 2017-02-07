unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, xmldom, XMLIntf, msxmldom, XMLDoc,
  MSHTML, ActiveX;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    txtNaziv: TEdit;
    Label1: TLabel;
    txtAdresa: TEdit;
    txtRacun: TEdit;
    txtMesto: TEdit;
    txtStatus: TEdit;
    txtOpstina: TEdit;
    txtDelatnost: TEdit;
    txtPIB: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    txtMB: TEdit;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function findChildByTagName(node: IHTMLElement; tagName: String): IHTMLElement;
    procedure ExtractAddressAndAccount(htmlTR: IHTMLElement; var address: String; var account: String);
    procedure ExtractCityAndStatus(htmlTR: IHTMLElement; var city: String; var status: String);
    procedure ExtractMunicipality(htmlTR: IHTMLElement; var municipality: String);
    procedure ExtractDelatnostAndPib(htmlTR: IHTMLElement; var delatnost: String; var pib: String);
    function  NasaSlova(tekst: String): String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses unNBS;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  lHTTP: TIdHTTP;
  lParamList: TStringList;
  Cache: string;
  V: OleVariant;
  Doc: IHTMLDocument2;
  htmlElement: IHTMLElement;
  htmlTableBody: IHTMLElement;
  htmlForm: IHTMLElement;
  htmlA: IHTMLElement;
  i: Integer;
  j: Integer;

  naziv: String;
  adresa: String;
  racun: String;
  mesto: String;
  status: String;
  opstina: String;
  delatnost: String;
  pib: String;

  NBSPodaci: TNBSPodaci;
begin
  NBSPodaci := NBSPretraga(txtMB.Text);
    txtNaziv.Text := NBSPodaci.naziv;
    txtAdresa.Text := NBSPodaci.adresa;
    txtRacun.Text := NBSPodaci.racun;
    txtMesto.Text := NBSPodaci.mesto;
    txtStatus.Text := NBSPodaci.status;
    txtOpstina.Text := NBSPodaci.opstina;
    txtDelatnost.Text := NBSPodaci.delatnost;
    txtPIB.Text := NBSPodaci.pib;
  {
  lParamList := TStringList.Create;
  lParamList.Add('sifban=');
  lParamList.Add('partija=');
  lParamList.Add('kontbr=');
  lParamList.Add('matbr=' + txtMB.Text);
  lParamList.Add('pib=');
  lParamList.Add('korisnik=');
  lParamList.Add('mesto=');
  lParamList.Add('tip_racuna=1');
  lParamList.Add('rezident=1');
  lParamList.Add('Submit=Pretra%C5%BEi');

  lHTTP := TIdHTTP.Create(nil);
  lHTTP.Request.CustomHeaders.Add('Content-Type=application/x-www-form-urlencoded');
  try
    Memo1.Text := lHTTP.Post('http://www.nbs.rs/rir_pn/pn_rir.html.jsp?type=rir_results&lang=SER_CIR&konverzija=yes', lParamList);

    Doc := coHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
    V := VarArrayCreate([0,0], varVariant);
    V[0] := Memo1.Text;
    Doc.Write(PSafeArray(TVarData(v).VArray)); // write data from IdHTTP
    for i := 0 to Doc.all.length - 1 do
    begin
      htmlElement := Doc.all.item(i, EmptyParam) as IHTMLElement;
      if htmlElement.getAttribute('id',0) = 'result' then
      begin
        htmlForm := findChildByTagName(htmlElement, 'form');
        if htmlForm <> nil then
        begin
          htmlA := findChildByTagName(htmlForm, 'a');
          naziv := NasaSlova(htmlA.innerHTML);
        end;
        htmlTableBody := IHtmlElementCollection(htmlElement.children).item(0, EmptyParam) as IHTMLElement;
        for j := 0 to IHtmlElementCollection(htmlTableBody.children).length - 1 do
        begin
          if j = 2 then ExtractAddressAndAccount(IHtmlElementCollection(htmlTableBody.children).item(j, EmptyParam) as IHTMLElement, adresa, racun);
          if j = 3 then ExtractCityAndStatus(IHtmlElementCollection(htmlTableBody.children).item(j, EmptyParam) as IHTMLElement, mesto, status);
          if j = 4 then ExtractMunicipality(IHtmlElementCollection(htmlTableBody.children).item(j, EmptyParam) as IHTMLElement, opstina);
          if j = 5 then ExtractDelatnostAndPib(IHtmlElementCollection(htmlTableBody.children).item(j, EmptyParam) as IHTMLElement, delatnost, pib);
        end;
      end;
    end;
    txtNaziv.Text := naziv;
    txtAdresa.Text := adresa;
    txtRacun.Text := racun;
    txtMesto.Text := mesto;
    txtStatus.Text := status;
    txtOpstina.Text := opstina;
    txtDelatnost.Text := StringReplace(delatnost, 'ƒç', 'Ë', [rfReplaceAll]);
    txtPIB.Text := pib;
  finally
    lHTTP.Free;
    lParamList.Free;
  end;
  }
end;

procedure TForm1.ExtractAddressAndAccount(htmlTR: IHTMLElement;
  var address, account: String);
begin
  address := (IHtmlElementCollection(htmlTR.children).item(1, EmptyParam) as  IHTMLElement).innerHTML;
  account := (IHtmlElementCollection( (IHtmlElementCollection(htmlTR.children).item(3, EmptyParam) as  IHTMLElement).children).item(0, EmptyParam) as IHTMLElement).innerHTML;

  address := NasaSlova(address);
  account := NasaSlova(account);
end;

procedure TForm1.ExtractCityAndStatus(htmlTR: IHTMLElement; var city,
  status: String);
begin
  city := (IHtmlElementCollection(htmlTR.children).item(1, EmptyParam) as  IHTMLElement).innerHTML;
  status := (IHtmlElementCollection((IHtmlElementCollection((IHtmlElementCollection(htmlTR.children).item(3, EmptyParam) as  IHTMLElement).children).item(1, EmptyParam) as IHTMLElement).children).item(0, EmptyParam) as IHTMLElement).innerHTML;

  city := NasaSlova(city);
  status := NasaSlova(status);
end;

procedure TForm1.ExtractDelatnostAndPib(htmlTR: IHTMLElement;
  var delatnost, pib: String);
begin
  delatnost := (IHtmlElementCollection(htmlTR.children).item(1, EmptyParam) as  IHTMLElement).innerHTML;
  pib := (IHtmlElementCollection(htmlTR.children).item(3, EmptyParam) as  IHTMLElement).innerHTML;

  delatnost := NasaSlova(delatnost);
  pib := NasaSlova(pib);
end;

procedure TForm1.ExtractMunicipality(htmlTR: IHTMLElement;
  var municipality: String);
begin
  municipality := (IHtmlElementCollection(htmlTR.children).item(1, EmptyParam) as  IHTMLElement).innerHTML;
  municipality := NasaSlova(municipality);
end;

function TForm1.findChildByTagName(node: IHTMLElement; tagName: String): IHTMLElement;
var i: Integer;
    htmlElement: IHTMLElement;
begin
  if node = nil then
    Result := nil
  else
  begin
    if node.tagName = UpperCase(tagName) then
      Result := node
    else
      for i := 0 to IHtmlElementCollection(node.children).length - 1 do
      begin
        htmlElement := IHtmlElementCollection(node.children).item(i, EmptyParam) as IHTMLElement;
        Result := findChildByTagName(htmlElement, tagName);
        if Result <> nil then
          Exit;
      end;
  end;
end;

function TForm1.NasaSlova(tekst: String): String;
begin
  Result := StringReplace(tekst, 'ƒç', 'Ë', [rfReplaceAll]);
  Result := StringReplace(tekst, '&nbsp;', '', [rfReplaceAll]);
  Result := StringReplace(Result, '≈æ', 'û', [rfReplaceAll]);
  Result := StringReplace(Result, '≈', 'ä', [rfReplaceAll]);

end;

end.
