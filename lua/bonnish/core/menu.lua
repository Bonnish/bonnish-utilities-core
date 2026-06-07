BonnishBase = BonnishBase or {}
BonnishBase.MenuHTMLContent = [[
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-base: #050505;
            --bg-surface: #121212;
            --bg-surface-hover: #1a1a1a;
            
            --border: rgba(255, 255, 255, 0.08);
            --border-hover: rgba(147, 51, 234, 0.5);
            
            --text-main: #fcfcfc;
            --text-muted: #888888;
            
            --accent: #9333ea;
            --accent-hover: #a855f7;
            
            --status-installed: #10b981;
            --status-outdated: #f59e0b;
            --status-missing: #ef4444;
            
            --radius-lg: 12px;
            --radius-md: 8px;
            --radius-sm: 6px;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Outfit', sans-serif;
            background: transparent;
            color: var(--text-main);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            user-select: none;
            overflow: hidden;
            padding: 20px;
        }

        .app-container {
            width: 100%;
            height: 100%;
            background: rgba(5, 5, 5, 0.90);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: var(--radius-lg);
            border: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            flex-direction: column;
            overflow: hidden;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
        }

        
        .titlebar {
            height: 48px;
            background: rgba(5, 5, 5, 0.6);
            display: flex;
            align-items: center;
            padding: 0 20px;
            border-bottom: 1px solid var(--border);
            flex-shrink: 0;
        }

        .titlebar-name {
            flex: 1;
            font-size: 14px;
            font-weight: 500;
            color: var(--text-muted);
            letter-spacing: 0.05em;
        }

        .close-btn {
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: var(--radius-sm);
            color: var(--text-muted);
            cursor: pointer;
            font-size: 16px;
            transition: all 0.2s ease;
        }

        .close-btn:hover {
            background: rgba(239, 68, 68, 0.15);
            color: var(--status-missing);
        }

        
        .main-tabs {
            display: flex;
            background: rgba(18, 18, 18, 0.4);
            border-bottom: 1px solid var(--border);
            padding: 0 20px;
        }

        .main-tab {
            padding: 14px 20px;
            font-size: 14px;
            font-weight: 500;
            color: var(--text-muted);
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all 0.2s ease;
        }

        .main-tab:hover { color: var(--text-main); }
        .main-tab.active {
            color: var(--accent);
            border-bottom-color: var(--accent);
        }

        
        .layout { display: flex; flex: 1; overflow: hidden; }

        
        .sidebar {
            width: 240px;
            background: rgba(5, 5, 5, 0.4);
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            padding: 20px 0;
        }

        .sidebar-header {
            padding: 0 20px 16px;
            border-bottom: 1px solid var(--border);
            margin-bottom: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .sidebar-label {
            font-size: 12px;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.1em;
            font-weight: 600;
        }
        
        .sidebar-version {
            font-size: 10px;
            color: var(--text-muted);
            background: rgba(255, 255, 255, 0.1);
            padding: 2px 6px;
            border-radius: 10px;
        }

        .addon-item {
            padding: 12px 20px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 12px;
            border-left: 3px solid transparent;
            transition: all 0.2s ease;
            margin: 2px 0;
        }

        .addon-item:hover { background: rgba(255, 255, 255, 0.03); }
        .addon-item.active {
            background: rgba(147, 51, 234, 0.1);
            border-left-color: var(--accent);
        }

        .addon-status {
            width: 8px; height: 8px; border-radius: 50%; flex-shrink: 0;
        }
        .installed { background: var(--status-installed); box-shadow: 0 0 8px rgba(16, 185, 129, 0.6); }
        .outdated { background: var(--status-outdated); box-shadow: 0 0 8px rgba(245, 158, 11, 0.6); }
        .missing { background: var(--status-missing); box-shadow: 0 0 8px rgba(239, 68, 68, 0.6); }
        .unknown { background: var(--text-muted); }

        .addon-item-name {
            font-size: 14px;
            color: var(--text-muted);
            font-weight: 500;
        }
        .addon-item.active .addon-item-name { color: var(--text-main); }

        
        .content { flex: 1; display: flex; flex-direction: column; overflow: hidden; }

        .content-header {
            padding: 24px 32px 16px;
            border-bottom: 1px solid var(--border);
            background: linear-gradient(to right, rgba(18, 18, 18, 0.3), transparent);
        }

        .content-title { font-size: 22px; font-weight: 600; color: var(--text-main); }
        .content-meta { font-size: 13px; color: var(--text-muted); margin-top: 4px; }

        .content-body {
            flex: 1; overflow-y: auto; padding: 24px 32px;
        }

        
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: rgba(255, 255, 255, 0.15); border-radius: 3px; }
        ::-webkit-scrollbar-thumb:hover { background: rgba(255, 255, 255, 0.25); }

        
        .section-label {
            font-size: 12px;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.1em;
            margin-bottom: 12px;
            font-weight: 600;
        }

        .job-row {
            display: flex; align-items: center; justify-content: space-between;
            padding: 14px 16px;
            background: var(--bg-surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            margin-bottom: 8px;
            transition: all 0.2s ease;
        }
        .job-row:hover { border-color: var(--border-hover); transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .job-row-name { font-size: 14px; font-weight: 500; color: var(--text-main); }

        
        .toggle {
            width: 44px; height: 24px;
            background: rgba(0,0,0,0.3);
            border-radius: 12px;
            position: relative;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 1px solid var(--border);
            flex-shrink: 0;
        }
        .toggle.on { background: var(--accent); border-color: var(--accent); }
        .toggle-thumb {
            width: 18px; height: 18px;
            background: var(--text-muted);
            border-radius: 50%;
            position: absolute;
            top: 2px; left: 3px;
            transition: all 0.3s cubic-bezier(0.4, 0.0, 0.2, 1);
        }
        .toggle.on .toggle-thumb {
            left: 21px; background: #fff;
            box-shadow: 0 0 8px rgba(255,255,255,0.4);
        }

        
        .btn {
            padding: 10px 20px;
            font-size: 13px;
            font-weight: 500;
            border-radius: var(--radius-md);
            cursor: pointer;
            border: 1px solid transparent;
            transition: all 0.2s ease;
            font-family: inherit;
        }
        .btn-ghost { background: transparent; color: var(--text-muted); border-color: var(--border); }
        .btn-ghost:hover { background: rgba(255,255,255,0.05); color: var(--text-main); }
        .btn-primary {
            background: var(--accent); color: #fff;
            box-shadow: 0 4px 12px rgba(147, 51, 234, 0.3);
        }
        .btn-primary:hover { background: var(--accent-hover); transform: translateY(-1px); }

        .add-job-btn {
            width: 100%; padding: 14px;
            background: transparent;
            border: 1px dashed var(--border);
            border-radius: var(--radius-md);
            color: var(--text-muted);
            font-size: 13px; font-weight: 500;
            cursor: pointer; text-align: center;
            transition: all 0.2s ease;
        }
        .add-job-btn:hover { border-color: var(--accent); color: var(--accent); background: rgba(147, 51, 234, 0.05); }

        input.setting-input, select.setting-input {
            width: 100%; padding: 14px 16px;
            background: rgba(0, 0, 0, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: var(--radius-md);
            color: var(--text-main);
            font-size: 14px; font-family: inherit;
            outline: none; transition: all 0.2s ease;
        }
        input.setting-input:focus, select.setting-input:focus { border-color: var(--accent); background: rgba(0, 0, 0, 0.6); box-shadow: 0 0 0 2px rgba(147, 51, 234, 0.2); }

        .footer {
            padding: 16px 32px;
            border-top: 1px solid var(--border);
            display: flex; justify-content: flex-end; gap: 12px;
            background: rgba(5, 5, 5, 0.6);
        }

        
        .welcome {
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            flex: 1; gap: 12px; color: var(--text-muted); height: 100%;
        }
        .welcome-icon { font-size: 48px; opacity: 0.8; margin-bottom: 8px; filter: drop-shadow(0 0 16px rgba(147,51,234,0.4)); }
        .welcome-title { font-size: 20px; font-weight: 600; color: var(--text-main); }
        .welcome-sub { font-size: 14px; }

        
        .core-header {
            display: flex; align-items: center; gap: 20px;
            margin-bottom: 32px; padding-bottom: 24px;
            border-bottom: 1px solid var(--border);
        }
        .core-logo {
            width: 56px; height: 56px;
            border-radius: 16px;
            background: linear-gradient(135deg, rgba(147,51,234,0.2), rgba(5,5,5,0.8));
            border: 1px solid var(--border-hover);
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            flex-shrink: 0;
        }
        .core-logo svg { width: 28px; height: 28px; fill: var(--accent); }
        .core-title { font-size: 24px; font-weight: 700; color: var(--text-main); }
        .core-subtitle { font-size: 14px; color: var(--text-muted); margin-top: 4px; }
        
        .core-github {
            margin-left: auto; display: flex; align-items: center; gap: 8px;
            padding: 10px 16px; background: var(--bg-surface);
            border: 1px solid var(--border); border-radius: var(--radius-md);
            color: var(--text-main); font-size: 13px; font-weight: 500;
            cursor: pointer; transition: all 0.2s ease; text-decoration: none;
        }
        .core-github:hover { border-color: var(--accent); color: var(--accent); transform: translateY(-2px); box-shadow: 0 4px 12px rgba(147,51,234,0.15); }
        .core-github svg { width: 16px; height: 16px; fill: currentColor; }

        .addons-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 16px; }

        .addon-card {
            display: flex; align-items: center; gap: 16px;
            padding: 16px 20px; background: var(--bg-surface);
            border: 1px solid var(--border); border-radius: var(--radius-lg);
            transition: all 0.2s ease;
        }
        .addon-card:hover { border-color: var(--border-hover); transform: translateY(-2px); box-shadow: 0 10px 20px rgba(0,0,0,0.2); }
        
        .addon-card-info { flex: 1; }
        .addon-card-name { font-size: 16px; color: var(--text-main); font-weight: 600; margin-bottom: 4px; }
        .addon-card-version { font-size: 12px; color: var(--text-muted); }
        
        .addon-card-badge { font-size: 11px; padding: 4px 10px; border-radius: 20px; font-weight: 600; letter-spacing: 0.05em; }
        .badge-installed { background: rgba(16, 185, 129, 0.1); color: var(--status-installed); border: 1px solid rgba(16, 185, 129, 0.2); }
        .badge-outdated { background: rgba(245, 158, 11, 0.1); color: var(--status-outdated); border: 1px solid rgba(245, 158, 11, 0.2); }
        .badge-missing { background: rgba(239, 68, 68, 0.1); color: var(--status-missing); border: 1px solid rgba(239, 68, 68, 0.2); }
        .badge-unknown { background: rgba(255, 255, 255, 0.05); color: var(--text-muted); border: 1px solid var(--border); }

        .addon-card-github {
            display: flex; align-items: center; justify-content: center;
            width: 36px; height: 36px; border-radius: var(--radius-md);
            background: rgba(255,255,255,0.05); color: var(--text-muted);
            cursor: pointer; transition: all 0.2s ease; border: 1px solid var(--border);
        }
        .addon-card-github:hover { background: var(--accent); color: #fff; border-color: var(--accent); }
        .addon-card-github svg { width: 16px; height: 16px; fill: currentColor; }

        .legend { display: flex; gap: 20px; margin-bottom: 24px; padding: 16px; background: rgba(0,0,0,0.2); border-radius: var(--radius-md); }
        .legend-item { display: flex; align-items: center; gap: 8px; font-size: 12px; font-weight: 500; color: var(--text-muted); }

        .job-selector {
            display: flex; flex-direction: column; gap: 4px;
            max-height: 250px; overflow-y: auto;
            background: rgba(0,0,0,0.3); border: 1px solid var(--border);
            border-radius: var(--radius-md); padding: 8px;
            margin-top: 12px;
        }
        .job-category {
            font-size: 11px; font-weight: 700; text-transform: uppercase;
            letter-spacing: 0.1em; padding: 8px 12px; margin-top: 8px;
            border-radius: 4px; display: flex; justify-content: space-between;
            align-items: center; cursor: pointer; transition: all 0.2s ease;
            background: rgba(255,255,255,0.02);
        }
        .job-category:hover { filter: brightness(1.2); background: rgba(255,255,255,0.05); }
        .job-category:first-child { margin-top: 0; }

        .job-option {
            padding: 8px 12px; margin-left: 12px; border-radius: 4px;
            font-size: 13px; color: var(--text-main); display: flex;
            align-items: center; gap: 10px; cursor: pointer; transition: all 0.2s ease;
            background: transparent; border: 1px solid transparent;
        }
        .job-option:hover { background: rgba(255,255,255,0.05); }
        .job-color-dot { width: 10px; height: 10px; border-radius: 50%; flex-shrink:0; }
        .job-option.selected, .job-category.selected { background: rgba(147, 51, 234, 0.15); border: 1px solid var(--accent); }

        
        .modal-overlay {
            display: none; position: fixed; top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0, 0, 0, 0.7); backdrop-filter: blur(6px);
            align-items: center; justify-content: center; z-index: 100;
        }
        .modal-overlay.visible { display: flex; animation: fadeIn 0.2s ease; }
        .modal {
            background: var(--bg-surface); border: 1px solid var(--border);
            border-radius: var(--radius-lg); padding: 24px; width: 360px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
            animation: slideUp 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .modal-title { font-size: 18px; font-weight: 600; color: var(--text-main); margin-bottom: 16px; }
        .modal-btns { display: flex; justify-content: flex-end; gap: 12px; margin-top: 20px; }

        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        @keyframes slideUp { from { opacity: 0; transform: translateY(20px) scale(0.95); } to { opacity: 1; transform: translateY(0) scale(1); } }
    </style>
</head>
<body>

    <div class="app-container">
        <div class="titlebar">
            <div class="titlebar-name" data-lang="core_title">Bonnish Utilities</div>
            <div class="close-btn" onclick="bonnish.Close()">✕</div>
        </div>

        <div class="main-tabs">
            <div class="main-tab active" data-lang="tab_dashboard" onclick="switchMainTab('core', this)">Dashboard</div>
            <div class="main-tab" data-lang="tab_config" onclick="switchMainTab('addons', this)">Configuration</div>
        </div>

        
        <div id="page-core" class="content-body" style="display:block;">
            <div class="core-header">
                <div class="core-logo">
                    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2C6.477 2 2 6.477 2 12c0 4.42 2.865 8.166 6.839 9.489.5.092.682-.217.682-.482 0-.237-.008-.866-.013-1.7-2.782.604-3.369-1.34-3.369-1.34-.454-1.156-1.11-1.462-1.11-1.462-.908-.62.069-.608.069-.608 1.003.07 1.531 1.03 1.531 1.03.892 1.529 2.341 1.087 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.11-4.555-4.943 0-1.091.39-1.984 1.029-2.683-.103-.253-.446-1.27.098-2.647 0 0 .84-.269 2.75 1.025A9.578 9.578 0 0112 6.836c.85.004 1.705.114 2.504.336 1.909-1.294 2.747-1.025 2.747-1.025.546 1.377.203 2.394.1 2.647.64.699 1.028 1.592 1.028 2.683 0 3.842-2.339 4.687-4.566 4.935.359.309.678.919.678 1.852 0 1.336-.012 2.415-.012 2.743 0 .267.18.579.688.481C19.138 20.163 22 16.418 22 12c0-5.523-4.477-10-10-10z" />
                    </svg>
                </div>
                <div>
                    <div class="core-title" data-lang="core_title">Bonnish Utilities</div>
                    <div class="core-subtitle" data-lang="core_subtitle">Central Config Panel</div>
                </div>
                <a class="core-github" onclick="bonnish.OpenURL('https://github.com/Bonnish')">
                    <svg viewBox="0 0 24 24"><path d="M12 2C6.477 2 2 6.477 2 12c0 4.42 2.865 8.166 6.839 9.489.5.092.682-.217.682-.482 0-.237-.008-.866-.013-1.7-2.782.604-3.369-1.34-3.369-1.34-.454-1.156-1.11-1.462-1.11-1.462-.908-.62.069-.608.069-.608 1.003.07 1.531 1.03 1.531 1.03.892 1.529 2.341 1.087 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.11-4.555-4.943 0-1.091.39-1.984 1.029-2.683-.103-.253-.446-1.27.098-2.647 0 0 .84-.269 2.75 1.025A9.578 9.578 0 0112 6.836c.85.004 1.705.114 2.504.336 1.909-1.294 2.747-1.025 2.747-1.025.546 1.377.203 2.394.1 2.647.64.699 1.028 1.592 1.028 2.683 0 3.842-2.339 4.687-4.566 4.935.359.309.678.919.678 1.852 0 1.336-.012 2.415-.012 2.743 0 .267.18.579.688.481C19.138 20.163 22 16.418 22 12c0-5.523-4.477-10-10-10z"/></svg>
                    GitHub
                </a>
            </div>

            <div class="legend">
                <div class="legend-item"><div class="addon-status installed"></div> <span data-lang="status_installed">Installed</span></div>
                <div class="legend-item"><div class="addon-status outdated"></div> <span data-lang="status_update">Update Available</span></div>
                <div class="legend-item"><div class="addon-status missing"></div> <span data-lang="status_missing">No Installed</span></div>
            </div>

            <div class="section-label" data-lang="your_addons">Your Addons</div>
            <div class="addons-grid" id="addons-grid"></div>
        </div>

        
        <div id="page-addons" style="display:none;" class="layout">
            <div class="sidebar">
                <div class="sidebar-header">
                    <div class="sidebar-label" data-lang="installed_addons">Addons Installeds</div>
                    <div class="sidebar-version">v1.0</div>
                </div>
                <div id="addon-list"></div>
            </div>

            <div class="content">
                <div class="content-header" id="content-header" style="display:none">
                    <div class="content-title" id="addon-title"></div>
                    <div class="content-meta" id="addon-meta"></div>
                </div>

                <div class="content-body" id="settings-content">
                    <div class="welcome">
                        <div class="welcome-icon">⚙️</div>
                        <div class="welcome-title" data-lang="select_addon">Select an addon</div>
                        <div class="welcome-sub" data-lang="select_addon_sub">Choose an installed addon on the left to configure it</div>
                    </div>
                </div>

                <div class="footer" id="footer" style="display:none">
                    <button id="btn-cancel" class="btn btn-ghost" onclick="cancelChanges()" data-lang="btn_discard">Discard</button>
                    <button id="btn-save" class="btn btn-primary" onclick="saveChanges()" data-lang="btn_save">Save Changes</button>
                </div>
            </div>
        </div>
    </div>

    
    <div class="modal-overlay" id="modal">
        <div class="modal">
            <div class="modal-title" id="modal-title" data-lang="add_item">Add Item</div>
            <input type="text" id="job-input" class="setting-input" placeholder="Type here..." />
            <div id="job-selector" class="job-selector" style="display:none;"></div>
            <div class="modal-btns">
                <button class="btn btn-ghost" onclick="closeModal()" data-lang="btn_cancel">Cancel</button>
                <button class="btn btn-primary" onclick="confirmAddListItem()" data-lang="btn_add">Add</button>
            </div>
        </div>
    </div>

    <script>
        var state = {
            addons: {},
            missing: {},
            config: {},
            currentAddon: null,
            dirty: false,
            gamemode: 'sandbox'
        };

        var GITHUB_SVG = '<svg viewBox="0 0 24 24"><path d="M12 2C6.477 2 2 6.477 2 12c0 4.42 2.865 8.166 6.839 9.489.5.092.682-.217.682-.482 0-.237-.008-.866-.013-1.7-2.782.604-3.369-1.34-3.369-1.34-.454-1.156-1.11-1.462-1.11-1.462-.908-.62.069-.608.069-.608 1.003.07 1.531 1.03 1.531 1.03.892 1.529 2.341 1.087 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.11-4.555-4.943 0-1.091.39-1.984 1.029-2.683-.103-.253-.446-1.27.098-2.647 0 0 .84-.269 2.75 1.025A9.578 9.578 0 0112 6.836c.85.004 1.705.114 2.504.336 1.909-1.294 2.747-1.025 2.747-1.025.546 1.377.203 2.394.1 2.647.64.699 1.028 1.592 1.028 2.683 0 3.842-2.339 4.687-4.566 4.935.359.309.678.919.678 1.852 0 1.336-.012 2.415-.012 2.743 0 .267.18.579.688.481C19.138 20.163 22 16.418 22 12c0-5.523-4.477-10-10-10z"/></svg>';

        var lang_data = {};
        function setLang(data) {
            lang_data = data;
            document.querySelectorAll('[data-lang]').forEach(function(el) {
                var txt = t(el.getAttribute('data-lang'));
                if (txt) el.innerHTML = txt;
            });
            document.getElementById('job-input').placeholder = t('type_here') || "Type here...";
        }
        function t(key) { return lang_data[key] || key; }

        function receiveData(data) {
            state.gamemode = data.gamemode || 'sandbox';
            state.darkrp_jobs = data.darkrp_jobs || [];
            
            state.addons = data.addons || {};
            if (Array.isArray(state.addons)) state.addons = {};
            
            state.missing = data.missing || {};
            if (Array.isArray(state.missing)) state.missing = {};
            
            state.config = data.config || {};
            if (Array.isArray(state.config)) state.config = {};

            renderCoreTab();
            renderSidebar();
        }

        function renderCoreTab() {
            var grid = document.getElementById('addons-grid');
            grid.innerHTML = '';

            var all = {};
            Object.keys(state.addons).forEach(function (id) { all[id] = state.addons[id]; });
            Object.keys(state.missing).forEach(function (id) { all[id] = state.missing[id]; });

            Object.keys(all).forEach(function (id) {
                var addon = all[id];
                var status = addon.status || 'unknown';
                var badgeText = { installed: t('status_installed'), outdated: t('status_update'), missing: t('status_missing'), unknown: t('status_unknown') }[status] || t('status_unknown');
                var badgeClass = 'badge-' + status;
                var indicatorClass = 'addon-status ' + status;
                var github = addon.workshop || '';

                var card = document.createElement('div');
                card.className = 'addon-card';
                card.innerHTML =
                    '<div class="' + indicatorClass + '"></div>' +
                    '<div class="addon-card-info">' +
                    '<div class="addon-card-name">' + addon.name + '</div>' +
                    '<div class="addon-card-version">v' + (addon.version || '?') + '</div>' +
                    '</div>' +
                    '<div class="addon-card-badge ' + badgeClass + '">' + badgeText + '</div>' +
                    (github ? '<div class="addon-card-github" onclick="bonnish.OpenURL(\'' + github + '\')" title="Ver Workshop/GitHub">' + GITHUB_SVG + '</div>' : '');
                grid.appendChild(card);
            });

            if (Object.keys(all).length === 0) {
                grid.innerHTML = '<div style="font-size:14px;color:var(--text-muted);padding:20px 0;">' + t('no_addons_db') + '</div>';
            }
        }

        function renderSidebar() {
            var list = document.getElementById('addon-list');
            list.innerHTML = '';
            var keys = Object.keys(state.addons);
            if (keys.length === 0) {
                list.innerHTML = '<div style="padding:20px;font-size:13px;color:var(--text-muted);text-align:center;">' + t('no_addons_installed') + '</div>';
                return;
            }
            keys.forEach(function (id) {
                var addon = state.addons[id];
                var el = document.createElement('div');
                el.className = 'addon-item';
                el.dataset.id = id;
                el.innerHTML =
                    '<div class="addon-status ' + (addon.status || 'unknown') + '"></div>' +
                    '<div class="addon-item-name">' + addon.name + '</div>';
                el.onclick = function () { selectAddon(id); };
                list.appendChild(el);
            });
        }

        function selectAddon(id) {
            state.currentAddon = id;
            var addon = state.addons[id];
            document.querySelectorAll('.addon-item').forEach(function (el) {
                el.classList.toggle('active', el.dataset.id === id);
            });
            document.getElementById('content-header').style.display = 'block';
            document.getElementById('footer').style.display = 'flex';
            document.getElementById('addon-title').textContent = addon.name;
            document.getElementById('addon-meta').textContent = 'v' + (addon.version || '1.0') + ' — Bonnish Utilities';
            renderSettings();
        }

        var activeListId = null;

        function renderSettings() {
            var id = state.currentAddon;
            var addon = state.addons[id];
            var html = '';

            if (!addon || !addon.settings || addon.settings.length === 0) {
                html = '<div class="welcome"><div class="welcome-icon">⚡</div><div class="welcome-title">' + t('no_config') + '</div><div class="welcome-sub">' + t('no_config_sub') + '</div></div>';
                document.getElementById('settings-content').innerHTML = html;
                return;
            }

            if (!state.config[id]) state.config[id] = {};

            addon.settings.forEach(function (setting) {
                if (setting.requireGamemode) {
                    var reqs = Array.isArray(setting.requireGamemode) ? setting.requireGamemode : [setting.requireGamemode];
                    if (reqs.indexOf(state.gamemode) === -1) {
                        return;
                    }
                }

                var value = state.config[id][setting.id];
                if (value === undefined) value = setting.default;
                
                if (setting.type === 'boolean') {
                    var isOn = value === true;
                    var descHtml = setting.desc ? '<div style="font-size:12px;color:var(--text-muted);margin-top:4px;">' + t(setting.desc) + '</div>' : '';
                    html += '<div class="job-row">' +
                        '<div><div class="job-row-name">' + t(setting.name) + '</div>' + descHtml + '</div>' +
                        '<div class="toggle ' + (isOn ? 'on' : '') + '" onclick="toggleBoolean(\'' + setting.id + '\', this)">' +
                        '<div class="toggle-thumb"></div>' +
                        '</div></div>';
                } else if (setting.type === 'string') {
                    var descHtml = setting.desc ? '<div style="font-size:12px;color:var(--text-muted);margin-top:4px;margin-bottom:8px;">' + t(setting.desc) + '</div>' : '';
                    html += '<div class="section-label" style="margin-top:20px;margin-bottom:0px;">' + t(setting.name) + '</div>' + descHtml +
                        '<input type="text" class="setting-input" value="' + (value || '') + '" onchange="updateString(\'' + setting.id + '\', this.value)" style="margin-bottom:16px;">';
                } else if (setting.type === 'string_list' || setting.type === 'job_list') {
                    var descHtml = setting.desc ? '<div style="font-size:12px;color:var(--text-muted);margin-top:4px;margin-bottom:8px;">' + t(setting.desc) + '</div>' : '';
                    var list = value || [];
                    html += '<div class="section-label" style="margin-top:20px;margin-bottom:0px;">' + t(setting.name) + '</div>' + descHtml + '<div style="display:flex;flex-direction:column;gap:8px;margin-bottom:12px;">';
                    list.forEach(function (item) {
                        var colHtml = '';
                        if (setting.type === 'job_list') {
                            var col = getJobColor(item);
                            if (item.startsWith('[CAT] ')) {
                                colHtml = '<div style="width:4px;height:14px;background:' + col + ';border-radius:2px;margin-right:8px;"></div>';
                            } else {
                                colHtml = '<div class="job-color-dot" style="background:' + col + '; box-shadow: 0 0 8px ' + col + '; margin-right:8px;"></div>';
                            }
                        }
                        html += '<div class="job-row" style="margin-bottom:0;">' +
                            '<div style="display:flex;align-items:center;">' + colHtml + '<div class="job-row-name">' + item + '</div></div>' +
                            '<div class="toggle on" onclick="removeListItem(\'' + setting.id + '\', \'' + item.replace(/'/g, "\\'") + '\')">' +
                            '<div class="toggle-thumb"></div>' +
                            '</div></div>';
                    });
                    html += '</div><button class="add-job-btn" onclick="openListModal(\'' + setting.id + '\', \'' + setting.name + '\', \'' + setting.type + '\')">+ ' + t('add_item') + '</button><div style="margin-bottom:20px;"></div>';
                }
            });

            document.getElementById('settings-content').innerHTML = html;
        }

        function toggleBoolean(settingId, el) {
            el.classList.toggle('on');
            var id = state.currentAddon;
            state.config[id][settingId] = el.classList.contains('on');
            state.dirty = true;
        }

        function updateString(settingId, val) {
            var id = state.currentAddon;
            state.config[id][settingId] = val;
            state.dirty = true;
        }

        function removeListItem(settingId, item) {
            var id = state.currentAddon;
            var list = state.config[id][settingId] || [];
            state.config[id][settingId] = list.filter(function (j) { return j !== item; });
            state.dirty = true;
            renderSettings();
        }

        function switchMainTab(tab, el) {
            document.querySelectorAll('.main-tab').forEach(function (t) { t.classList.remove('active'); });
            el.classList.add('active');
            document.getElementById('page-core').style.display = tab === 'core' ? 'block' : 'none';
            var addonsPage = document.getElementById('page-addons');
            addonsPage.style.display = tab === 'addons' ? 'flex' : 'none';
        }

        var activeListType = 'string_list';
        var selectedJobValue = '';

        function colorToRGBA(col) {
            if (!col) return 'rgba(255,255,255,1)';
            return 'rgba(' + (col.r||255) + ',' + (col.g||255) + ',' + (col.b||255) + ',' + ((col.a!==undefined?col.a:255)/255) + ')';
        }

        function getJobColor(name) {
            if (!state.darkrp_jobs) return 'rgba(255,255,255,1)';
            for (var i = 0; i < state.darkrp_jobs.length; i++) {
                var cat = state.darkrp_jobs[i];
                if ('[CAT] ' + cat.name === name) return colorToRGBA(cat.color);
                for (var j = 0; j < cat.jobs.length; j++) {
                    if (cat.jobs[j].name === name) return colorToRGBA(cat.jobs[j].color);
                }
            }
            return 'rgba(255,255,255,1)';
        }

        function renderJobSelector() {
            var html = '';
            state.darkrp_jobs.forEach(function(cat) {
                var catBg = colorToRGBA(cat.color);
                var isCatSel = selectedJobValue === '[CAT] ' + cat.name ? ' selected' : '';
                html += '<div class="job-category job-sel-item' + isCatSel + '" style="border-left: 4px solid ' + catBg + '" onclick="selectJob(\'[CAT] ' + cat.name.replace(/'/g, "\\'") + '\', this)">' + cat.name + ' <span style="font-size:10px;opacity:0.5">' + t('category') + '</span></div>';
                cat.jobs.forEach(function(job) {
                    var jobCol = colorToRGBA(job.color);
                    var isSel = selectedJobValue === job.name ? ' selected' : '';
                    html += '<div class="job-option job-sel-item' + isSel + '" onclick="selectJob(\'' + job.name.replace(/'/g, "\\'") + '\', this)">' +
                            '<div class="job-color-dot" style="background:' + jobCol + '; box-shadow: 0 0 8px ' + jobCol + '"></div>' +
                            job.name +
                            '</div>';
                });
            });
            if(html === '') html = '<div style="padding:10px;text-align:center;color:var(--text-muted);font-size:13px;">' + t('no_jobs_found') + '</div>';
            document.getElementById('job-selector').innerHTML = html;
        }

        function selectJob(val, el) {
            selectedJobValue = val;
            document.querySelectorAll('.job-sel-item').forEach(function(e) { e.classList.remove('selected'); });
            if (el) el.classList.add('selected');
        }

        function openListModal(settingId, name, listType) {
            activeListId = settingId;
            activeListType = listType || 'string_list';
            document.getElementById('modal-title').textContent = t('add_to') + name;
            
            if (activeListType === 'job_list') {
                document.getElementById('job-input').style.display = 'none';
                document.getElementById('job-selector').style.display = 'flex';
                selectedJobValue = '';
                renderJobSelector();
            } else {
                document.getElementById('job-input').style.display = 'block';
                document.getElementById('job-selector').style.display = 'none';
                document.getElementById('job-input').value = '';
                document.getElementById('job-input').placeholder = 'Item for ' + name + '...';
            }
            
            document.getElementById('modal').classList.add('visible');
            setTimeout(function () {
                if (activeListType === 'job_list') document.getElementById('job-select').focus();
                else document.getElementById('job-input').focus();
            }, 50);
        }

        function closeModal() { document.getElementById('modal').classList.remove('visible'); }

        function confirmAddListItem() {
            var val = "";
            if (activeListType === 'job_list') {
                val = selectedJobValue;
            } else {
                val = document.getElementById('job-input').value.trim();
            }
            
            if (!val || !activeListId) return;
            var id = state.currentAddon;
            if (!state.config[id][activeListId]) state.config[id][activeListId] = [];
            if (state.config[id][activeListId].indexOf(val) === -1) {
                state.config[id][activeListId].push(val);
            }
            state.dirty = true;
            closeModal();
            renderSettings();
        }

        function saveChanges() {
            bonnish.SaveConfig(JSON.stringify(state.config));
            state.dirty = false;
            
            var btn = document.getElementById('btn-save');
            var originalText = btn.textContent;
            btn.textContent = t('btn_saved');
            btn.style.background = 'var(--status-installed)';
            btn.style.boxShadow = '0 4px 12px rgba(16, 185, 129, 0.4)';
            
            setTimeout(function() {
                btn.textContent = originalText;
                btn.style.background = '';
                btn.style.boxShadow = '';
            }, 2000);
        }

        function cancelChanges() {
            bonnish.Close();
        }

        document.getElementById('job-input').addEventListener('keydown', function (e) {
            if (e.key === 'Enter') confirmAddListItem();
            if (e.key === 'Escape') closeModal();
        });

        window.onload = function() {
            setTimeout(function() {
                if (window.bonnish && bonnish.Ready) {
                    bonnish.Ready();
                }
            }, 50);
        };
    </script>
</body>
</html>
]]
