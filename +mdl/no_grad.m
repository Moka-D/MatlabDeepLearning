function cm = no_grad()
    cm = mdl.ConfigManager('enable_backprop', false);
end
