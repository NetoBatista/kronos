using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Kronos.Domain.Migrations
{
    /// <inheritdoc />
    public partial class CascadeTables : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "healthcheck_applicationid_fkey",
                table: "healthcheck");

            migrationBuilder.DropForeignKey(
                name: "log_applicationid_fkey",
                table: "log");

            migrationBuilder.AddForeignKey(
                name: "healthcheck_applicationid_fkey",
                table: "healthcheck",
                column: "applicationid",
                principalTable: "application",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "log_applicationid_fkey",
                table: "log",
                column: "applicationid",
                principalTable: "application",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "healthcheck_applicationid_fkey",
                table: "healthcheck");

            migrationBuilder.DropForeignKey(
                name: "log_applicationid_fkey",
                table: "log");

            migrationBuilder.AddForeignKey(
                name: "healthcheck_applicationid_fkey",
                table: "healthcheck",
                column: "applicationid",
                principalTable: "application",
                principalColumn: "id");

            migrationBuilder.AddForeignKey(
                name: "log_applicationid_fkey",
                table: "log",
                column: "applicationid",
                principalTable: "application",
                principalColumn: "id");
        }
    }
}
