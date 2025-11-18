# TypeScript 5.3.3 + @vitejs/plugin-react-swc 4.2.2 Incompatibility

This is a minimal reproduction of a TypeScript compatibility issue.

## The Problem

`@vitejs/plugin-react-swc` version 4.x uses string literal export names in its type definitions:

```typescript
export { pluginForCjs as "module.exports" };
```

This syntax was introduced in TypeScript 5.5, but this project uses TypeScript 5.3.3.

**Important:** The error only occurs when `vite.config.ts` is included in the TypeScript compilation (via `tsconfig.json` include array). When TypeScript checks the config file, it also type-checks the imported plugin types, which triggers the incompatibility.

## Reproduce the Error

1. Install dependencies:
   ```bash
   npm install
   ```

2. Run the build:
   ```bash
   npm run build
   ```

3. You'll see these errors:
   ```
   node_modules/@vitejs/plugin-react-swc/index.d.ts(58,44): error TS1003: Identifier expected.
   node_modules/@vitejs/plugin-react-swc/index.d.ts(58,61): error TS1128: Declaration or statement expected.
   ```

## Solutions

### Option 1: Upgrade TypeScript (Recommended)
```bash
npm install typescript@^5.5.0
```

### Option 2: Downgrade the plugin
```bash
npm install @vitejs/plugin-react-swc@^3.9.0
```
Note: This loses Vite 7 compatibility.

### Option 3: Disable TypeScript checking in vite.config.ts
```typescript
checker({
  typescript: false, // Temporary workaround
})
```

## References

- Source of the problematic export: https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react-swc/src/index.ts#L321
- TypeScript 5.5 Release Notes (String Literal Export Names)