// @ts-check

/**
 * @type {import('typedoc').TypeDocOptions & import('typedoc-plugin-markdown').PluginOptions}
 */
module.exports = {
    entryPoints: ["src/index.ts"],
    entryPointStrategy: "expand",
    tsconfig: "./tsconfig.json",
    plugin: [
      require.resolve("./../../docs/typedoc-nextauth.cjs"),
      require.resolve("./../../docs/typedoc-mdn-links.cjs"),
    ],
    entryFileName: "../cosmosdb.mdx",
    entryModule: "@auth/cosmosdb-adapter",
    includeVersion: true,
    readme: 'none'
  }