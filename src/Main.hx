import js.Browser;
import js.html.XMLHttpRequest;

typedef GitHubUser = {
    var login:String;
    var name:String;
    var avatar_url:String;
    var public_repos:Int;
    var followers:Int;
    var following:Int;
    var bio:String;
    var html_url:String;
}

class Main {
    static function main() {
        // 最初は何も表示しない
    }

    public static function fetchUser(username:String) {
        var url = 'https://api.github.com/users/$username';
        var req = new XMLHttpRequest();
        req.open("GET", url, true);

        req.onload = function(_) {
            if (req.status == 200) {
                var data:GitHubUser = haxe.Json.parse(req.responseText);
                displayUser(data);
            } else {
                Browser.document.getElementById("result").innerHTML =
                    "<p>ユーザーが見つかりませんでした。</p>";
            }
        }

        req.onerror = function(_) {
            Browser.document.getElementById("result").innerHTML =
                "<p>ネットワークエラー</p>";
        }

        req.send();
    }

    static function displayUser(u:GitHubUser) {
        Browser.document.getElementById("result").innerHTML = '
            <h2>${u.name} (@${u.login})</h2>
            <img src="${u.avatar_url}" width="120">
            <p>${u.bio}</p>
            <p>Repos: ${u.public_repos}</p>
            <p>Followers: ${u.followers}</p>
            <p>Following: ${u.following}</p>
            <a href="${u.html_url}" target="_blank">GitHub Profile</a>
        ';
    }
}
