using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Kronos.Domain.Migrations
{
    /// <inheritdoc />
    public partial class CreateDatabase : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "application",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    key = table.Column<Guid>(type: "uuid", nullable: false),
                    name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    healthcheck = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: false),
                    createdat = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("application_pkey", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "healthcheck",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    applicationid = table.Column<Guid>(type: "uuid", nullable: false),
                    success = table.Column<bool>(type: "boolean", nullable: false),
                    createdat = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("healthcheck_pkey", x => x.id);
                    table.ForeignKey(
                        name: "healthcheck_applicationid_fkey",
                        column: x => x.applicationid,
                        principalTable: "application",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "log",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    applicationid = table.Column<Guid>(type: "uuid", nullable: false),
                    content = table.Column<string>(type: "text", nullable: false),
                    type = table.Column<string>(type: "character varying(10)", maxLength: 10, nullable: false),
                    createdat = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("log_pkey", x => x.id);
                    table.ForeignKey(
                        name: "log_applicationid_fkey",
                        column: x => x.applicationid,
                        principalTable: "application",
                        principalColumn: "id");
                });

            migrationBuilder.CreateIndex(
                name: "application_name_key",
                table: "application",
                column: "name",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_healthcheck_applicationid",
                table: "healthcheck",
                column: "applicationid");

            migrationBuilder.CreateIndex(
                name: "IX_log_applicationid",
                table: "log",
                column: "applicationid");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "healthcheck");

            migrationBuilder.DropTable(
                name: "log");

            migrationBuilder.DropTable(
                name: "application");
        }
    }
}
