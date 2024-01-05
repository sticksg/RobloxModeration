--[[

    Simple instructions (you imported the .rbxm file):
        1. Place the "Remotes" folder into ReplicatedStorage.
        2. Place the AdminPanel GUI instance into ServerStorage.
        3. Place ModerationClient localscript into StarterPlayer > StarterPlayerScripts
        4. Place Moderation script into ServerScriptService.
        5. Place the Services folder into ServerScriptService. 
        🚨 - Please note that misplacing instances can break the system, or may require you to change variables.

    Complicated Instructions (you are copy-pasting):
        1. Create a "Remotes" folder, and place it in ReplicatedStorage.
        2. Create a RemoteFunction instance, and place it in the Remotes folder. Name the instance "ModerationFunction".
        3. Create a RemoteEvent instance, and place it in the Remotes folder. Name the instance "ModerationAction."
        4. Create a ScreenGui instance named "AdminPanel" and place it in ServerStorage.
        5. Create a frame, place it in the AdminPanel instance.
        6. Create a Textbox instance, place it in the frame instance.
        7. Follow instructions above for script setup.
        
]]