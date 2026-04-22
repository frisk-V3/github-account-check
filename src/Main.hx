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
        var username = "frisk-scratch"; // ← 調べたいアカウント
        fetchUser(username);
    }

    static function fetchUser(username:String) {
        var url = 'https://api.github.com/users/$username';
        var req = new XMLHttpRequest();

        req.open("GET", url, true);

        req.onload = function(_) {
            if (req.status == 200) {
                var data:GitHubUser = haxe.Json.parse(req.responseText);
                displayUser(data);
            } else {
                Browser.console.error("GitHub API error: " + req.status);
            }
        }

        req.onerror = function(_) {
            Browser.console.error("Network error");
        }

        req.send();
    }

    static function displayUser(u:GitHubUser) {
        var doc = Browser.document;

        doc.body.innerHTML = '
            <h1>${u.name} (@${u.login})</h1>
            <img src="${u.avatar_url}" width="120" style="border-radius:60px;">
            <p>${u.bio}</p>
            <p>Repos: ${u.public_repos}</p>
            <p>Followers: ${u.followers}</p>
            <p>Following: ${u.following}</p>
            <a href="${u.html_url}" target="_blank">GitHub Profile</a>
        ';
    }
}
