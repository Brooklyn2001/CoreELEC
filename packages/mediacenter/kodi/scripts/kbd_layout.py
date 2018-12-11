# -*- coding: utf-8 -*-

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

import os, json
import xbmc, xbmcgui

kodi_json = {}
params = {}
params["setting"] = "input.libinputkeyboardlayout"
kodi_json["jsonrpc"] = "2.0"
kodi_json["method"] = "Settings.GetSettingValue"
kodi_json["params"] = params
kodi_json["id"] = 1

request = xbmc.executeJSONRPC(json.dumps(kodi_json).encode("utf-8"))
response = json.loads(request.decode('utf-8', 'replace'))

if 'result' in response:
    kodi_json["method"] = "Settings.SetSettingValue"
    params["setting"] = "input.libinputkeyboardlayout"
    if response['result']['value'] == 'us':
        params["value"] = "ru"
        request = xbmc.executeJSONRPC(json.dumps(kodi_json).encode("utf-8"))
        response = json.loads(request.decode('utf-8', 'replace'))
        if response['result']:
            xbmc.executebuiltin('Notification("Keybord", "set keyboard layout: Russian (RU)", 5000)')
        else:
            xbmc.executebuiltin('Notification("Keybord", "Error set keyboard layout!", 5000)')
    else:
        params["value"] = "us"
        request = xbmc.executeJSONRPC(json.dumps(kodi_json).encode("utf-8"))
        response = json.loads(request.decode('utf-8', 'replace'))
        if response['result']:
            xbmc.executebuiltin('Notification("Keybord", "set keyboard layout: English (US)", 5000)')
        else:
            xbmc.executebuiltin('Notification("Keybord", "Error set keyboard layout!", 5000)')
