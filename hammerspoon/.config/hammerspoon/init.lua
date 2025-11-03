-- --------------------------------------------------------------------------
-- Handle OS dark mode for Hammerspoon
-- --------------------------------------------------------------------------

dm = require "darkmode"
dm.addHandler(
  function(dm2) 
    if dm2 then
      hs.console.darkMode(true)
      hs.preferencesDarkMode(true)
    else
      hs.console.darkMode(false)
      hs.preferencesDarkMode(false)
    end 
  end
)

if dm.getDarkMode() then
  hs.console.darkMode(true)
  hs.preferencesDarkMode(true)
else
  hs.console.darkMode(false)
  hs.preferencesDarkMode(false)
end

-- --------------------------------------------------------------------------
-- Setup SpoonInstall
-- --------------------------------------------------------------------------

hs.loadSpoon("SpoonInstall")
---spoon.SpoonInstall.repos.Hammerflow = {
---  url = "https://github.com/kyrarae/Hammerflow",
---  desc = "Unoffcial Hammerflow repository"
---}
Install = spoon.SpoonInstall
