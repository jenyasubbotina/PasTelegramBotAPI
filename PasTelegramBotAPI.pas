unit PasTelegramBotAPI;

interface

uses
    System, System.IO, System.Net, System.Web;

const
    telegramUrl = 'https://api.telegram.org/bot';

type
    TBot = class
    private 
        TBotToken: string;
    public 
        constructor Create(token: string);
        function GetUpdates(offset: integer := 0; limit: integer := 10; timeout: integer := 0): string;
        function SendMessage(chatID: string; message: string): string;
    end;

implementation

constructor TBot.Create(token: string);
begin
    TBotToken := Token;
end;

function TBot.GetUpdates(offset: integer; limit: integer; timeout: integer): string;
var
    request: HttpWebRequest;
    readstream: StreamReader;
    res: string;
begin
    ServicePointManager.SecurityProtocol := SecurityProtocolType.Tls12 or SecurityProtocolType.Tls11 or SecurityProtocolType.Tls;
    request := HttpWebRequest(WebRequest.Create(telegramUrl + TBotToken + '/getUpdates'));
    request.Method := 'GET';
    readstream := new StreamReader(request.GetResponse.GetResponseStream, System.Text.Encoding.UTF8);
    res := readstream.ReadToEnd;
    readstream.Close;
    Result := res;
end;

function TBot.SendMessage(chatID: string; message: string): string;
var
    request: HttpWebRequest;
begin
    request := HttpWebRequest(WebRequest.Create(telegramUrl + TBotToken + '/sendMessage?chat_id=' + chatID + '&text=' + message));
    request.Method := 'POST';
    var byteArray := Encoding.UTF8.GetBytes(message);
    request.ContentType := 'application/x-www-form-urlencoded';
    request.ContentLength := byteArray.Length;
    var dataStream := request.GetRequestStream();
    dataStream.Write(byteArray, 0, byteArray.Length);
    dataStream.Close();
    Writeln(telegramUrl + TBotToken + '/sendMessage?chat_id=' + chatID + '&' + message);
    var response: WebResponse := request.GetResponse();
    writeln(((HttpWebResponse)(response)).StatusDescription);
    dataStream := response.GetResponseStream();
    var reader: StreamReader := new StreamReader(dataStream);
    var responseFromServer := reader.ReadToEnd();
    writeln(responsefromserver);
    response.Close();
end;

end.