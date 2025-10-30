classdef MyProjectToolBoxApp_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure
        SearchTable            matlab.ui.control.Table
        AddButton              matlab.ui.control.Button
        Panel_2                matlab.ui.container.Panel
        ComprehensiveMATLABScriptsCollectionLabel  matlab.ui.control.Label
        ProjectToolboxLabel    matlab.ui.control.Label
        HelpButton             matlab.ui.control.Button
        Panel                  matlab.ui.container.Panel
        ProjectToolboxv10ClickthumbnailstorunapplicationsLabel  matlab.ui.control.Label
        StatsLabel             matlab.ui.control.Label
        ActionLabel            matlab.ui.control.Label
        Image3                 matlab.ui.control.Image
        EscapeButton           matlab.ui.control.Image
        SearchEditField        matlab.ui.control.EditField
        RunOpenAbout           matlab.ui.control.DropDown
        TabGroup               matlab.ui.container.TabGroup
        MainScriptsTab         matlab.ui.container.Tab
        GridLayout             matlab.ui.container.GridLayout
        Image4                 matlab.ui.control.Image
        ExampleLabel           matlab.ui.control.Label
        Image                  matlab.ui.control.Image
        ProjectToolboxLabel_2  matlab.ui.control.Label
        OthersTab              matlab.ui.container.Tab
        GridLayout_2           matlab.ui.container.GridLayout
    end

    properties (Access = public)
        scripts_registry
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.scripts_registry = readtable('scripts_registry.xlsx'); % Read excel
            app.StatsLabel.Text = sprintf('📊 %d Scripts Available', height(app.scripts_registry)); % Update stats
        end

        % Image clicked function: Image, Image4
        function ImageClicked(app, event)
                [~, selectedScript , ~] = fileparts(event.Source.ImageSource);
                UserClicked(app, selectedScript); % Function
        end

        % Cell selection callback: SearchTable
        function SearchTableClicked(app, event)
            row = event.Indices(1, 1); % Get the selected row
            selectedScript = app.SearchTable.Data{row, 1}; % Get the script name
            
            if strcmp(selectedScript, 'No matches found') % if "No matches found" was selected
                return
            end
            
            app.SearchTable.Data = {};
            app.SearchTable.Visible = 'off';
            UserClicked(app, selectedScript); % Funcion
        end

        % Value changing function: SearchEditField
        function SearchEditFieldValueChanging(app, event)
            selectedScript = event.Value;
            if isempty(selectedScript) && strcmp(app.EscapeButton.Visible, 'off') % To fix an appdesigner bug
                return
            end
            matches = contains(app.scripts_registry.ScriptName, selectedScript, 'IgnoreCase', true) | ...
                      contains(app.scripts_registry.Category, selectedScript, 'IgnoreCase', true);
            FilteredResults = app.scripts_registry(matches, :);
            if height(FilteredResults) == 0
                app.SearchTable.Data = {'No matches found', ''};
            else
                app.SearchTable.Data = [FilteredResults.ScriptName, FilteredResults.Category]; % Update Table with results
            end
            app.SearchTable.Visible = 'on';
            app.EscapeButton.Visible = 'on';
        end

        % Image clicked function: EscapeButton
        function EscapeButtonClicked(app, event)
            app.SearchEditField.Value = '';
            app.SearchTable.Visible = 'off';
            app.EscapeButton.Visible = 'off';
        end

        % Button pushed function: AddButton
        function AddButtonPushed(app, event)
            % Open Excel file
            winopen('scripts_registry.xlsx');
            
            % Show instruction dialog
            msg = sprintf(['✅ Excel file opened!\n\n' ...
                '📝 INSTRUCTIONS:\n\n' ...
                '1. Add your scripts to the registry\n' ...
                '2. Save the Excel file\n' ...
                '3. Reload the App\n\n' ...
                '📋 Required columns:\n' ...
                '   • ScriptName\n' ...
                '   • Path\n' ...
                '   • About (optional)']);
            
            uialert(app.UIFigure, msg, '📝 Edit Registry', 'Icon', 'info');
            disp('5');
        end

        % Button pushed function: HelpButton
        function Help(app, event)
            helpText = sprintf(['Welcome to the Project Toolbox!\n\n' ...
                '• Use the search bar to find scripts quickly\n' ...
                '• Select "Run" to execute a script\n' ...
                '• Select "Open" to edit the script\n' ...
                '• Select "About" to read script description\n\n' ...
                'Click on any figure to run script.']);
            uialert(app.UIFigure, helpText, 'Help', 'Icon', 'info');            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 554 568];
            app.UIFigure.Name = 'Toolbox App';
            app.UIFigure.Icon = fullfile(pathToMLAPP, 'Figures', 'AppSymbols', 'rocket.png');

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [13 44 529 409];

            % Create MainScriptsTab
            app.MainScriptsTab = uitab(app.TabGroup);
            app.MainScriptsTab.Title = '📚 Main Scripts';

            % Create GridLayout
            app.GridLayout = uigridlayout(app.MainScriptsTab);
            app.GridLayout.ColumnWidth = {'1x', '1x', '1x', '1x'};
            app.GridLayout.RowHeight = {'1x', '3x', '1x', '3x', '1x', '3x', '1x', '3x'};

            % Create ProjectToolboxLabel_2
            app.ProjectToolboxLabel_2 = uilabel(app.GridLayout);
            app.ProjectToolboxLabel_2.HorizontalAlignment = 'center';
            app.ProjectToolboxLabel_2.VerticalAlignment = 'bottom';
            app.ProjectToolboxLabel_2.FontWeight = 'bold';
            app.ProjectToolboxLabel_2.Layout.Row = 1;
            app.ProjectToolboxLabel_2.Layout.Column = 1;
            app.ProjectToolboxLabel_2.Text = 'ProjectToolbox';

            % Create Image
            app.Image = uiimage(app.GridLayout);
            app.Image.ImageClickedFcn = createCallbackFcn(app, @ImageClicked, true);
            app.Image.Layout.Row = 2;
            app.Image.Layout.Column = 1;
            app.Image.ImageSource = fullfile(pathToMLAPP, 'Figures', 'Project Toolbox.png');

            % Create ExampleLabel
            app.ExampleLabel = uilabel(app.GridLayout);
            app.ExampleLabel.HorizontalAlignment = 'center';
            app.ExampleLabel.VerticalAlignment = 'bottom';
            app.ExampleLabel.FontWeight = 'bold';
            app.ExampleLabel.Layout.Row = 1;
            app.ExampleLabel.Layout.Column = 2;
            app.ExampleLabel.Text = 'Example';

            % Create Image4
            app.Image4 = uiimage(app.GridLayout);
            app.Image4.ImageClickedFcn = createCallbackFcn(app, @ImageClicked, true);
            app.Image4.Layout.Row = 2;
            app.Image4.Layout.Column = 2;
            app.Image4.ImageSource = fullfile(pathToMLAPP, 'Figures', 'Example.png');

            % Create OthersTab
            app.OthersTab = uitab(app.TabGroup);
            app.OthersTab.Title = '📁 Others';

            % Create GridLayout_2
            app.GridLayout_2 = uigridlayout(app.OthersTab);
            app.GridLayout_2.ColumnWidth = {'1x', '1x', '1x', '1x'};
            app.GridLayout_2.RowHeight = {'1x', '3x', '1x', '3x', '1x', '3x', '1x', '3x'};

            % Create RunOpenAbout
            app.RunOpenAbout = uidropdown(app.UIFigure);
            app.RunOpenAbout.Items = {'▶ Run', '📝 Open', 'ℹ About'};
            app.RunOpenAbout.ItemsData = {'Run', 'Open', 'About'};
            app.RunOpenAbout.FontWeight = 'bold';
            app.RunOpenAbout.FontColor = [0 0.4471 0.7412];
            app.RunOpenAbout.BackgroundColor = [1 1 1];
            app.RunOpenAbout.Position = [65 467 83 22];
            app.RunOpenAbout.Value = 'Run';

            % Create SearchEditField
            app.SearchEditField = uieditfield(app.UIFigure, 'text');
            app.SearchEditField.ValueChangingFcn = createCallbackFcn(app, @SearchEditFieldValueChanging, true);
            app.SearchEditField.Position = [205 467 276 22];

            % Create EscapeButton
            app.EscapeButton = uiimage(app.UIFigure);
            app.EscapeButton.ImageClickedFcn = createCallbackFcn(app, @EscapeButtonClicked, true);
            app.EscapeButton.Visible = 'off';
            app.EscapeButton.Position = [459 470 17 16];
            app.EscapeButton.ImageSource = fullfile(pathToMLAPP, 'Figures', 'AppSymbols', 'Escape.png');

            % Create Image3
            app.Image3 = uiimage(app.UIFigure);
            app.Image3.Position = [182 468 18 21];
            app.Image3.ImageSource = fullfile(pathToMLAPP, 'Figures', 'AppSymbols', 'icons8-search-48.png');

            % Create ActionLabel
            app.ActionLabel = uilabel(app.UIFigure);
            app.ActionLabel.FontWeight = 'bold';
            app.ActionLabel.Position = [15 467 46 22];
            app.ActionLabel.Text = 'Action:';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.BorderType = 'none';
            app.Panel.BackgroundColor = [0.902 0.902 0.902];
            app.Panel.Position = [1 1 554 32];

            % Create StatsLabel
            app.StatsLabel = uilabel(app.Panel);
            app.StatsLabel.FontWeight = 'bold';
            app.StatsLabel.FontColor = [0.2 0.6706 0.3882];
            app.StatsLabel.Position = [407 7 135 22];
            app.StatsLabel.Text = 'XX Scripts available';

            % Create ProjectToolboxv10ClickthumbnailstorunapplicationsLabel
            app.ProjectToolboxv10ClickthumbnailstorunapplicationsLabel = uilabel(app.Panel);
            app.ProjectToolboxv10ClickthumbnailstorunapplicationsLabel.FontSize = 10;
            app.ProjectToolboxv10ClickthumbnailstorunapplicationsLabel.FontColor = [0.4 0.4 0.4];
            app.ProjectToolboxv10ClickthumbnailstorunapplicationsLabel.Position = [16 6 304 22];
            app.ProjectToolboxv10ClickthumbnailstorunapplicationsLabel.Text = '© 2025 Project Toolbox | v1.0 | Click thumbnails to run applications';

            % Create Panel_2
            app.Panel_2 = uipanel(app.UIFigure);
            app.Panel_2.BorderType = 'none';
            app.Panel_2.BackgroundColor = [0.2 0.4 0.702];
            app.Panel_2.Position = [1 507 553 62];

            % Create HelpButton
            app.HelpButton = uibutton(app.Panel_2, 'push');
            app.HelpButton.ButtonPushedFcn = createCallbackFcn(app, @Help, true);
            app.HelpButton.BackgroundColor = [0.0745 0.6235 1];
            app.HelpButton.FontWeight = 'bold';
            app.HelpButton.FontColor = [1 1 1];
            app.HelpButton.Position = [501 15 37 34];
            app.HelpButton.Text = '?';

            % Create ProjectToolboxLabel
            app.ProjectToolboxLabel = uilabel(app.Panel_2);
            app.ProjectToolboxLabel.FontSize = 24;
            app.ProjectToolboxLabel.FontWeight = 'bold';
            app.ProjectToolboxLabel.FontColor = [1 1 1];
            app.ProjectToolboxLabel.Position = [15 21 185 32];
            app.ProjectToolboxLabel.Text = 'Project Toolbox';

            % Create ComprehensiveMATLABScriptsCollectionLabel
            app.ComprehensiveMATLABScriptsCollectionLabel = uilabel(app.Panel_2);
            app.ComprehensiveMATLABScriptsCollectionLabel.FontColor = [0.851 0.902 1];
            app.ComprehensiveMATLABScriptsCollectionLabel.Position = [15 4 238 22];
            app.ComprehensiveMATLABScriptsCollectionLabel.Text = 'Comprehensive MATLAB Scripts Collection';

            % Create AddButton
            app.AddButton = uibutton(app.UIFigure, 'push');
            app.AddButton.ButtonPushedFcn = createCallbackFcn(app, @AddButtonPushed, true);
            app.AddButton.BackgroundColor = [0.2 0.6706 0.3882];
            app.AddButton.FontWeight = 'bold';
            app.AddButton.FontColor = [1 1 1];
            app.AddButton.Position = [493 467 48 23];
            app.AddButton.Text = '+ Add';

            % Create SearchTable
            app.SearchTable = uitable(app.UIFigure);
            app.SearchTable.ColumnName = '';
            app.SearchTable.RowName = {};
            app.SearchTable.SelectionType = 'row';
            app.SearchTable.CellSelectionCallback = createCallbackFcn(app, @SearchTableClicked, true);
            app.SearchTable.Multiselect = 'off';
            app.SearchTable.ForegroundColor = [0 0.4471 0.7412];
            app.SearchTable.Visible = 'off';
            app.SearchTable.FontAngle = 'italic';
            app.SearchTable.FontWeight = 'bold';
            app.SearchTable.Position = [205 283 276 185];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = MyProjectToolBoxApp_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end