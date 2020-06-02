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
        constructor Create(Token: string);
        function GetUpdates(offset: integer := 0; limit: integer := 10; timeout: integer := 0): string;
    end;

implementation

constructor TBot.Create(Token: string);
begin
    TBotToken := Token;
end;

function TBot.GetUpdates(offset: integer; limit: integer; timeout: integer): string;
var
    request: HttpWebRequest;
    response: WebResponse;
    datastream: Stream;
    readstream: StreamReader;
    res: string;
begin
    ServicePointManager.SecurityProtocol := SecurityProtocolType.Tls12;
    request := HttpWebRequest(WebRequest.Create('https://api.telegram.org/bot1157303469:AAG9iUMm_meciVW8Vwiqb1ZdAgepWOyQowQ/getUpdates'));
    request.Method := 'GET';
    response := request.GetResponse;
    datastream := response.GetResponseStream;
    readstream := new StreamReader(response.GetResponseStream, System.Text.Encoding.UTF8);
    res := readstream.ReadToEnd;
    readstream.Close;
    response.Close; 
    Result := res;
end;

end.