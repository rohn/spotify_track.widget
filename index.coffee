command: """
read -r running <<<"$(ps -ef | grep \"MacOS/Spotify\" | grep -v \"grep\" | wc -l)" &&
test $running != 0 &&
IFS='|' read -r theArtist theName theState <<<"$(osascript <<<'tell application "Spotify"
        set theTrack to current track
        set theArtist to artist of theTrack
        set theName to name of theTrack
        set theState to player state as string
        return theArtist & "|" & theName & "|" & theState
    end tell')" &&
echo "<div class='title'> $theState - $theName</div><div class='artist'>$theArtist</div>" || echo "Not Connected To Spotify"
"""

refreshFrequency: 2000

style: """
  bottom: 0px
  left: 0px
  color: #fff
  margin: 0
  background: transparent;

  .output
    background-image: url(spotify_track.widget/img/right.png)
    background-position: right
    background-repeat: no-repeat
    height: 22px
    float: left
    padding-right: 73px

  .text
    height: 22px
    float: left
    display: block
    line-height: 26px
    color: #fff
    font-family: 'Myriad Pro'
    font-size: 12px
    background-color: #000

  .icon
    width: 22px
    height: 18px
    float: left
    padding-top: 4px
    padding-left: 6px
    background-color: #000

  .title
    font-weight: bold
    color: #fff
    margin: 0px
    height: 22px
    float: left
    margin-right: 5px
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis

  .artist
    opacity: 0.6;
    padding: 0px
    height: 22px
    width: auto
    float: left
    max-width: none
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis
"""

render: (output) -> """
  <div class="output">
    <div class="icon"><img src="spotify_track.widget/img/icon.png"/></div>
  	<div class="text">#{output}</div>
  </div>
"""
