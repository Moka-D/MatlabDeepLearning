classdef ConfigManager < handle
    properties
       prop_setter
       old_value
    end

    methods
        function self = ConfigManager(prop_name, value)
            self.prop_setter = strcat('setget_', prop_name);
            self.old_value = mdl.Config.(self.prop_setter);
            mdl.Config.(self.prop_setter)(value);
        end

        function delete(self)
            if ~isempty(self.old_value)
                mdl.Config.(self.prop_setter)(self.old_value);
            end
        end
    end
end
