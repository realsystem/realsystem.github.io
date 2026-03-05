module.exports = {
    content: ['./src/**/*.{astro,html,js,jsx,ts,tsx}'],
    theme: {
        extend: {
            colors: {
                // Backgrounds
                'bg-primary': '#0f1419',
                'bg-secondary': '#1a1f28',
                'bg-tertiary': '#242933',
                'bg-card': '#1e242e',
                'bg-hover': '#2a3038',

                // Text
                'text-primary': '#e6edf3',
                'text-secondary': '#adbac7',
                'text-muted': '#768390',

                // Borders
                'border-primary': '#343942',
                'border-hover': '#444c56',

                // Brand Colors
                'accent': '#4eb56a',
                'accent-hover': '#5ec67a',
                'accent-muted': 'rgba(78, 181, 106, 0.1)',

                // Status
                'success': '#56d364',
                'warning': '#e3b341',
                'error': '#ff6b6b',
                'info': '#58a6ff',
            },
            fontFamily: {
                sans: ['Inter', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Helvetica', 'Arial', 'sans-serif'],
                mono: ['JetBrains Mono', 'SF Mono', 'Monaco', 'Cascadia Code', 'Courier New', 'monospace'],
            }
        }
    },
    plugins: []
};
