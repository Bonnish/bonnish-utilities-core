BonnishBase = BonnishBase or {}
BonnishBase.MenuHTMLContent = [[
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: #0d0d12;
            color: #c9c9d4;
            height: 100vh;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            user-select: none;
        }

        /* TITLEBAR */
        .titlebar {
            height: 40px;
            background: #09090e;
            display: flex;
            align-items: center;
            padding: 0 16px;
            border-bottom: 1px solid #1e1e2e;
            flex-shrink: 0;
        }

        .titlebar-name {
            flex: 1;
            text-align: center;
            font-size: 12px;
            color: #3a3a55;
            letter-spacing: 0.05em;
        }

        .close-btn {
            width: 28px;
            height: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 5px;
            color: #444;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.15s;
            flex-shrink: 0;
        }

        .close-btn:hover {
            background: #1e1e2e;
            color: #cc4444;
        }

        /* MAIN TABS */
        .main-tabs {
            display: flex;
            background: #09090e;
            border-bottom: 1px solid #1e1e2e;
            padding: 0 16px;
            flex-shrink: 0;
        }

        .main-tab {
            padding: 10px 16px;
            font-size: 12px;
            color: #444;
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all 0.15s;
            letter-spacing: 0.02em;
        }

        .main-tab:hover {
            color: #888;
        }

        .main-tab.active {
            color: #9b94e8;
            border-bottom-color: #6c63d8;
        }

        /* LAYOUT */
        .layout {
            display: flex;
            flex: 1;
            overflow: hidden;
        }

        /* SIDEBAR */
        .sidebar {
            width: 200px;
            background: #09090e;
            border-right: 1px solid #1e1e2e;
            display: flex;
            flex-direction: column;
            padding: 14px 0;
            flex-shrink: 0;
        }

        .sidebar-header {
            padding: 0 14px 12px;
            border-bottom: 1px solid #1e1e2e;
            margin-bottom: 10px;
        }

        .sidebar-label {
            font-size: 10px;
            color: #3a3a55;
            text-transform: uppercase;
            letter-spacing: 0.1em;
        }

        .sidebar-version {
            font-size: 10px;
            color: #2a2a3a;
            margin-top: 2px;
        }

        .addon-item {
            padding: 9px 14px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 9px;
            border-left: 2px solid transparent;
            transition: background 0.15s;
        }

        .addon-item:hover {
            background: #13131e;
        }

        .addon-item.active {
            background: #13131e;
            border-left-color: #6c63d8;
        }

        .addon-status {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            flex-shrink: 0;
        }

        .addon-status.installed {
            background: #28c840;
        }

        .addon-status.outdated {
            background: #febc2e;
        }

        .addon-status.missing {
            background: #ff5f57;
        }

        .addon-status.unknown {
            background: #2a2a3a;
        }

        .addon-item-name {
            font-size: 12px;
            color: #666;
        }

        .addon-item.active .addon-item-name {
            color: #c9c9d4;
        }

        /* CONTENT */
        .content {
            flex: 1;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .content-header {
            padding: 18px 22px 0;
            border-bottom: 1px solid #1e1e2e;
            flex-shrink: 0;
        }

        .content-title {
            font-size: 15px;
            font-weight: 600;
            color: #e0e0f0;
        }

        .content-meta {
            font-size: 11px;
            color: #3a3a55;
            margin-top: 3px;
            margin-bottom: 14px;
        }

        .sub-tabs {
            display: flex;
            gap: 2px;
        }

        .sub-tab {
            padding: 7px 14px;
            font-size: 12px;
            color: #444;
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all 0.15s;
        }

        .sub-tab:hover {
            color: #888;
        }

        .sub-tab.active {
            color: #9b94e8;
            border-bottom-color: #6c63d8;
        }

        .content-body {
            flex: 1;
            overflow-y: auto;
            padding: 20px 22px;
            display: flex;
            flex-direction: column;
        }

        .content-body::-webkit-scrollbar {
            width: 4px;
        }

        .content-body::-webkit-scrollbar-track {
            background: transparent;
        }

        .content-body::-webkit-scrollbar-thumb {
            background: #2a2a3a;
            border-radius: 2px;
        }

        .section-label {
            font-size: 10px;
            color: #3a3a55;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            margin-bottom: 10px;
        }

        /* JOB ROWS */
        .job-list {
            display: flex;
            flex-direction: column;
            gap: 6px;
            margin-bottom: 20px;
        }

        .job-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 14px;
            background: #09090e;
            border: 1px solid #1e1e2e;
            border-radius: 7px;
            transition: border-color 0.15s;
        }

        .job-row:hover {
            border-color: #2a2a3a;
        }

        .job-row-name {
            font-size: 13px;
            color: #aaa;
        }

        /* TOGGLE */
        .toggle {
            width: 36px;
            height: 19px;
            background: #1e1e2e;
            border-radius: 10px;
            position: relative;
            cursor: pointer;
            transition: background 0.2s;
            flex-shrink: 0;
        }

        .toggle.on {
            background: #6c63d8;
        }

        .toggle-thumb {
            width: 13px;
            height: 13px;
            background: #3a3a55;
            border-radius: 50%;
            position: absolute;
            top: 3px;
            left: 3px;
            transition: all 0.2s;
        }

        .toggle.on .toggle-thumb {
            left: 20px;
            background: #fff;
        }

        /* ADD BUTTON */
        .add-job-btn {
            width: 100%;
            padding: 9px 14px;
            background: transparent;
            border: 1px dashed #1e1e2e;
            border-radius: 7px;
            color: #3a3a55;
            font-size: 12px;
            cursor: pointer;
            text-align: left;
            transition: all 0.15s;
        }

        .add-job-btn:hover {
            border-color: #6c63d8;
            color: #9b94e8;
        }

        /* FOOTER */
        .footer {
            padding: 12px 22px;
            border-top: 1px solid #1e1e2e;
            display: flex;
            justify-content: flex-end;
            gap: 8px;
            background: #09090e;
            flex-shrink: 0;
        }

        .btn {
            padding: 7px 16px;
            font-size: 12px;
            border-radius: 6px;
            cursor: pointer;
            border: 1px solid #1e1e2e;
            transition: all 0.15s;
            font-family: inherit;
        }

        .btn-ghost {
            background: transparent;
            color: #555;
        }

        .btn-ghost:hover {
            background: #13131e;
            color: #aaa;
        }

        .btn-primary {
            background: #6c63d8;
            color: #e0e0f0;
            border-color: #6c63d8;
        }

        .btn-primary:hover {
            background: #7b73e0;
        }

        /* WELCOME */
        .welcome {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            flex: 1;
            gap: 8px;
            color: #3a3a55;
        }

        .welcome-icon {
            font-size: 28px;
            margin-bottom: 4px;
        }

        .welcome-title {
            font-size: 14px;
        }

        .welcome-sub {
            font-size: 12px;
            color: #2a2a3a;
        }

        /* CORE TAB */
        .core-body {
            flex: 1;
            overflow-y: auto;
            padding: 24px 28px;
        }

        .core-body::-webkit-scrollbar {
            width: 4px;
        }

        .core-body::-webkit-scrollbar-track {
            background: transparent;
        }

        .core-body::-webkit-scrollbar-thumb {
            background: #2a2a3a;
            border-radius: 2px;
        }

        .core-header {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 28px;
            padding-bottom: 20px;
            border-bottom: 1px solid #1e1e2e;
        }

        .core-logo {
            width: 44px;
            height: 44px;
            border-radius: 10px;
            background: #13131e;
            border: 1px solid #1e1e2e;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .core-logo svg {
            width: 22px;
            height: 22px;
            fill: #6c63d8;
        }

        .core-title {
            font-size: 16px;
            font-weight: 600;
            color: #e0e0f0;
        }

        .core-subtitle {
            font-size: 12px;
            color: #3a3a55;
            margin-top: 3px;
        }

        .core-github {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 7px;
            padding: 7px 14px;
            background: transparent;
            border: 1px solid #1e1e2e;
            border-radius: 6px;
            color: #555;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.15s;
            text-decoration: none;
        }

        .core-github:hover {
            border-color: #6c63d8;
            color: #9b94e8;
        }

        .core-github svg {
            width: 14px;
            height: 14px;
            fill: currentColor;
            flex-shrink: 0;
        }

        .addons-grid {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .addon-card {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px 16px;
            background: #09090e;
            border: 1px solid #1e1e2e;
            border-radius: 8px;
            transition: border-color 0.15s;
        }

        .addon-card:hover {
            border-color: #2a2a3a;
        }

        .addon-card-indicator {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            flex-shrink: 0;
        }

        .addon-card-indicator.installed {
            background: #28c840;
            box-shadow: 0 0 6px #28c84055;
        }

        .addon-card-indicator.outdated {
            background: #febc2e;
            box-shadow: 0 0 6px #febc2e55;
        }

        .addon-card-indicator.missing {
            background: #ff5f57;
            box-shadow: 0 0 6px #ff5f5755;
        }

        .addon-card-info {
            flex: 1;
        }

        .addon-card-name {
            font-size: 13px;
            color: #c9c9d4;
            font-weight: 500;
        }

        .addon-card-version {
            font-size: 11px;
            color: #3a3a55;
            margin-top: 2px;
        }

        .addon-card-badge {
            font-size: 10px;
            padding: 3px 8px;
            border-radius: 4px;
            font-weight: 500;
            letter-spacing: 0.04em;
        }

        .badge-installed {
            background: #28c84015;
            color: #28c840;
            border: 1px solid #28c84030;
        }

        .badge-outdated {
            background: #febc2e15;
            color: #febc2e;
            border: 1px solid #febc2e30;
        }

        .badge-missing {
            background: #ff5f5715;
            color: #ff5f57;
            border: 1px solid #ff5f5730;
        }

        .badge-unknown {
            background: #2a2a3a;
            color: #555;
            border: 1px solid #2a2a3a;
        }

        .addon-card-github {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 30px;
            height: 30px;
            border-radius: 6px;
            border: 1px solid #1e1e2e;
            cursor: pointer;
            transition: all 0.15s;
            flex-shrink: 0;
            color: #444;
        }

        .addon-card-github:hover {
            border-color: #6c63d8;
            color: #9b94e8;
            background: #13131e;
        }

        .addon-card-github svg {
            width: 14px;
            height: 14px;
            fill: currentColor;
        }

        /* STATUS LEGEND */
        .legend {
            display: flex;
            gap: 16px;
            margin-bottom: 16px;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 11px;
            color: #3a3a55;
        }

        .legend-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
        }

        /* MODAL */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            align-items: center;
            justify-content: center;
            z-index: 100;
        }

        .modal-overlay.visible {
            display: flex;
        }

        .modal {
            background: #13131e;
            border: 1px solid #2a2a3a;
            border-radius: 10px;
            padding: 20px;
            width: 300px;
        }

        .modal-title {
            font-size: 13px;
            font-weight: 600;
            color: #e0e0f0;
            margin-bottom: 14px;
        }

        .modal input {
            width: 100%;
            padding: 8px 12px;
            background: #09090e;
            border: 1px solid #1e1e2e;
            border-radius: 6px;
            color: #c9c9d4;
            font-size: 12px;
            font-family: inherit;
            outline: none;
            margin-bottom: 12px;
        }

        .modal input:focus {
            border-color: #6c63d8;
        }

        .modal-btns {
            display: flex;
            justify-content: flex-end;
            gap: 8px;
        }
    </style>
</head>

<body>

    <div class="titlebar">
        <div class="titlebar-name">Bonnish Utilities Base</div>
        <div class="close-btn" onclick="bonnish.Close()">✕</div>
    </div>

    <div class="main-tabs">
        <div class="main-tab active" onclick="switchMainTab('core', this)">Bonnish Core</div>
        <div class="main-tab" onclick="switchMainTab('addons', this)">Configuración</div>
    </div>

    <!-- CORE TAB -->
    <div id="page-core" class="core-body">
        <div class="core-header">
            <div class="core-logo">
                <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path
                        d="M12 2C6.477 2 2 6.477 2 12c0 4.42 2.865 8.166 6.839 9.489.5.092.682-.217.682-.482 0-.237-.008-.866-.013-1.7-2.782.604-3.369-1.34-3.369-1.34-.454-1.156-1.11-1.462-1.11-1.462-.908-.62.069-.608.069-.608 1.003.07 1.531 1.03 1.531 1.03.892 1.529 2.341 1.087 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.11-4.555-4.943 0-1.091.39-1.984 1.029-2.683-.103-.253-.446-1.27.098-2.647 0 0 .84-.269 2.75 1.025A9.578 9.578 0 0112 6.836c.85.004 1.705.114 2.504.336 1.909-1.294 2.747-1.025 2.747-1.025.546 1.377.203 2.394.1 2.647.64.699 1.028 1.592 1.028 2.683 0 3.842-2.339 4.687-4.566 4.935.359.309.678.919.678 1.852 0 1.336-.012 2.415-.012 2.743 0 .267.18.579.688.481C19.138 20.163 22 16.418 22 12c0-5.523-4.477-10-10-10z" />
                </svg>
            </div>
            <div>
                <div class="core-title">Bonnish Utilities</div>
                <div class="core-subtitle">Sistema base de addons por Bonnish</div>
            </div>
            <a class="core-github" onclick="bonnish.OpenURL('https://github.com/Bonnish')">
                <svg viewBox="0 0 24 24">
                    <path
                        d="M12 2C6.477 2 2 6.477 2 12c0 4.42 2.865 8.166 6.839 9.489.5.092.682-.217.682-.482 0-.237-.008-.866-.013-1.7-2.782.604-3.369-1.34-3.369-1.34-.454-1.156-1.11-1.462-1.11-1.462-.908-.62.069-.608.069-.608 1.003.07 1.531 1.03 1.531 1.03.892 1.529 2.341 1.087 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.11-4.555-4.943 0-1.091.39-1.984 1.029-2.683-.103-.253-.446-1.27.098-2.647 0 0 .84-.269 2.75 1.025A9.578 9.578 0 0112 6.836c.85.004 1.705.114 2.504.336 1.909-1.294 2.747-1.025 2.747-1.025.546 1.377.203 2.394.1 2.647.64.699 1.028 1.592 1.028 2.683 0 3.842-2.339 4.687-4.566 4.935.359.309.678.919.678 1.852 0 1.336-.012 2.415-.012 2.743 0 .267.18.579.688.481C19.138 20.163 22 16.418 22 12c0-5.523-4.477-10-10-10z" />
                </svg>
                GitHub
            </a>
        </div>

        <div class="legend">
            <div class="legend-item">
                <div class="legend-dot" style="background:#28c840"></div>Instalado
            </div>
            <div class="legend-item">
                <div class="legend-dot" style="background:#febc2e"></div>Actualización disponible
            </div>
            <div class="legend-item">
                <div class="legend-dot" style="background:#ff5f57"></div>No instalado
            </div>
        </div>

        <div class="section-label">Todos los addons</div>
        <div class="addons-grid" id="addons-grid"></div>
    </div>

    <!-- CONFIG TAB -->
    <div id="page-addons" style="display:none; flex:1; overflow:hidden; flex-direction:row;" class="layout">
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-label">Addons instalados</div>
                <div class="sidebar-version">v1.0</div>
            </div>
            <div id="addon-list"></div>
        </div>

        <div class="content">
            <div class="content-header" id="content-header" style="display:none">
                <div class="content-title" id="addon-title"></div>
                <div class="content-meta" id="addon-meta"></div>
                <div class="sub-tabs">
                    <div class="sub-tab active" onclick="switchSubTab('jobs')">Jobs DarkRP</div>
                    <div class="sub-tab" onclick="switchSubTab('general')">General</div>
                </div>
            </div>

            <div class="content-body" id="tab-jobs">
                <div id="jobs-content">
                    <div class="welcome">
                        <div class="welcome-icon">⚙</div>
                        <div class="welcome-title">Selecciona un addon</div>
                        <div class="welcome-sub">Elige un addon instalado para configurarlo</div>
                    </div>
                </div>
            </div>

            <div class="content-body" id="tab-general" style="display:none">
                <div class="section-label">General</div>
                <div style="font-size:12px;color:#3a3a55;">Sin opciones adicionales.</div>
            </div>

            <div class="footer" id="footer" style="display:none">
                <button class="btn btn-ghost" onclick="cancelChanges()">Cancelar</button>
                <button class="btn btn-primary" onclick="saveChanges()">Guardar cambios</button>
            </div>
        </div>
    </div>

    <!-- MODAL -->
    <div class="modal-overlay" id="modal">
        <div class="modal">
            <div class="modal-title">Agregar job</div>
            <input type="text" id="job-input" placeholder="Nombre exacto del job en DarkRP..." />
            <div class="modal-btns">
                <button class="btn btn-ghost" onclick="closeModal()">Cancelar</button>
                <button class="btn btn-primary" onclick="confirmAddJob()">Agregar</button>
            </div>
        </div>
    </div>

    <script>
        var state = {
            addons: {},
            missing: {},
            config: {},
            currentAddon: null,
            dirty: false
        };

        var GITHUB_SVG = '<svg viewBox="0 0 24 24"><path d="M12 2C6.477 2 2 6.477 2 12c0 4.42 2.865 8.166 6.839 9.489.5.092.682-.217.682-.482 0-.237-.008-.866-.013-1.7-2.782.604-3.369-1.34-3.369-1.34-.454-1.156-1.11-1.462-1.11-1.462-.908-.62.069-.608.069-.608 1.003.07 1.531 1.03 1.531 1.03.892 1.529 2.341 1.087 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.11-4.555-4.943 0-1.091.39-1.984 1.029-2.683-.103-.253-.446-1.27.098-2.647 0 0 .84-.269 2.75 1.025A9.578 9.578 0 0112 6.836c.85.004 1.705.114 2.504.336 1.909-1.294 2.747-1.025 2.747-1.025.546 1.377.203 2.394.1 2.647.64.699 1.028 1.592 1.028 2.683 0 3.842-2.339 4.687-4.566 4.935.359.309.678.919.678 1.852 0 1.336-.012 2.415-.012 2.743 0 .267.18.579.688.481C19.138 20.163 22 16.418 22 12c0-5.523-4.477-10-10-10z"/></svg>';

        function receiveData(data) {
            state.addons = data.addons || {};
            state.missing = data.missing || {};
            state.config = data.config || {};
            renderCoreTab();
            renderSidebar();
        }

        function renderCoreTab() {
            var grid = document.getElementById('addons-grid');
            grid.innerHTML = '';

            var all = {};
            Object.keys(state.addons).forEach(function (id) {
                all[id] = state.addons[id];
            });
            Object.keys(state.missing).forEach(function (id) {
                all[id] = state.missing[id];
            });

            Object.keys(all).forEach(function (id) {
                var addon = all[id];
                var status = addon.status || 'unknown';
                var badgeText = { installed: 'Instalado', outdated: 'Actualizar', missing: 'No instalado', unknown: 'Desconocido' }[status] || 'Desconocido';
                var badgeClass = 'badge-' + status;
                var indicatorClass = 'addon-card-indicator ' + status;
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
                    (github ? '<div class="addon-card-github" onclick="bonnish.OpenURL(\'' + github + '\')" title="Ver en GitHub">' + GITHUB_SVG + '</div>' : '');
                grid.appendChild(card);
            });

            if (Object.keys(all).length === 0) {
                grid.innerHTML = '<div style="font-size:12px;color:#3a3a55;padding:10px 0;">Ningún addon registrado.</div>';
            }
        }

        function renderSidebar() {
            var list = document.getElementById('addon-list');
            list.innerHTML = '';
            var keys = Object.keys(state.addons);
            if (keys.length === 0) {
                list.innerHTML = '<div style="padding:10px 14px;font-size:11px;color:#2a2a3a;">Ningún addon instalado</div>';
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
            switchSubTab('jobs');
            renderJobs();
        }

        function renderJobs() {
            var id = state.currentAddon;
            var addonConfig = state.config[id] || {};
            var jobs = addonConfig.allowed_jobs || [];
            var html = '<div class="section-label">Jobs con No Target permanente</div><div class="job-list">';
            jobs.forEach(function (job) {
                html += '<div class="job-row">' +
                    '<div class="job-row-name">' + job + '</div>' +
                    '<div class="toggle on" onclick="toggleJob(this,\'' + job + '\')">' +
                    '<div class="toggle-thumb"></div>' +
                    '</div></div>';
            });
            html += '</div><button class="add-job-btn" onclick="openModal()">+ Agregar job</button>';
            document.getElementById('jobs-content').innerHTML = html;
        }

        function toggleJob(el, job) {
            el.classList.toggle('on');
            var id = state.currentAddon;
            if (!state.config[id]) state.config[id] = { allowed_jobs: [] };
            if (!el.classList.contains('on')) {
                state.config[id].allowed_jobs = state.config[id].allowed_jobs.filter(function (j) { return j !== job; });
            }
            state.dirty = true;
        }

        function switchMainTab(tab, el) {
            document.querySelectorAll('.main-tab').forEach(function (t) { t.classList.remove('active'); });
            el.classList.add('active');
            document.getElementById('page-core').style.display = tab === 'core' ? 'block' : 'none';
            var addonsPage = document.getElementById('page-addons');
            addonsPage.style.display = tab === 'addons' ? 'flex' : 'none';
        }

        function switchSubTab(tab) {
            document.querySelectorAll('.sub-tab').forEach(function (t, i) {
                t.classList.toggle('active', (i === 0 && tab === 'jobs') || (i === 1 && tab === 'general'));
            });
            document.getElementById('tab-jobs').style.display = tab === 'jobs' ? 'flex' : 'none';
            document.getElementById('tab-general').style.display = tab === 'general' ? 'flex' : 'none';
        }

        function openModal() {
            document.getElementById('job-input').value = '';
            document.getElementById('modal').classList.add('visible');
            setTimeout(function () { document.getElementById('job-input').focus(); }, 50);
        }

        function closeModal() { document.getElementById('modal').classList.remove('visible'); }

        function confirmAddJob() {
            var jobName = document.getElementById('job-input').value.trim();
            if (!jobName) return;
            var id = state.currentAddon;
            if (!state.config[id]) state.config[id] = { allowed_jobs: [] };
            if (state.config[id].allowed_jobs.indexOf(jobName) === -1) {
                state.config[id].allowed_jobs.push(jobName);
            }
            state.dirty = true;
            closeModal();
            renderJobs();
        }

        function saveChanges() {
            bonnish.SaveConfig(JSON.stringify(state.config));
            state.dirty = false;
        }

        function cancelChanges() {
            if (state.dirty) bonnish.SaveConfig(JSON.stringify(state.config));
        }

        document.getElementById('job-input').addEventListener('keydown', function (e) {
            if (e.key === 'Enter') confirmAddJob();
            if (e.key === 'Escape') closeModal();
        });
    </script>
</body>

</html>
]]
