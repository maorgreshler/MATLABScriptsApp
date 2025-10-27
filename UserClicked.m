function UserClicked(app, selectedScript)

% 1. Lookup the script in the registry file
rowIdx = find(strcmp(app.scripts_registry.ScriptName, selectedScript ), 1);
assert(~isempty(rowIdx), 'Script not defined in "scripts_registry.xlsx".') % change to video!!


% 2. Perform the action selected by user
scriptPath = app.scripts_registry.Path{rowIdx};
if ~isfile(scriptPath)
    msg = sprintf(['The file:\n"%s"\nDoes not exist.\n\n', ...
          'Please update the entry for "%s" in "scripts_registry.xlsx".'], scriptPath, selectedScript);
    uialert(app.UIFigure, msg, 'Invalid File Path', 'Icon', 'error');
    return
end
switch app.RunOpenAbout.Value
    case 'Run'
        run(scriptPath);
        % delete(app);
    case 'Open'
        open(scriptPath);
        cd(fileparts(scriptPath));
    otherwise                 
        txt = app.scripts_registry.About{rowIdx};
        if ~isempty(regexp(txt, '[א-ת]', 'once')) % If contains Hebrew force RTL embedding
            txt = [char(8235) txt char(8236)];
        end
        uialert(app.UIFigure, txt, 'info', 'Icon', 'info');
end


end