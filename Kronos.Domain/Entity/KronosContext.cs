using Kronos.Domain.Configuration;
using Microsoft.EntityFrameworkCore;

namespace Kronos.Domain.Entity
{
    public partial class KronosContext : DbContext
    {
        public KronosContext()
        {
        }

        public KronosContext(DbContextOptions<KronosContext> options) : base(options)
        {
        }

        public virtual DbSet<Application> Application { get; set; }

        public virtual DbSet<HealthCheck> Healthcheck { get; set; }

        public virtual DbSet<Log> Log { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (optionsBuilder.IsConfigured)
            {
                return;
            }
            optionsBuilder.UseNpgsql(KronosContextConfiguration.ConnectionString);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Application>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("application_pkey");

                entity.ToTable("application");

                entity.HasIndex(e => e.Name, "application_name_key").IsUnique();

                entity.Property(e => e.Id)
                    .HasDefaultValueSql("gen_random_uuid()")
                    .HasColumnName("id");

                entity.Property(e => e.CreatedAt).HasColumnName("createdat");

                entity.Property(e => e.HealthCheck)
                    .HasMaxLength(1000)
                    .HasColumnName("healthcheck");

                entity.Property(e => e.Key).HasColumnName("key");

                entity.Property(e => e.Name)
                    .HasMaxLength(100)
                    .HasColumnName("name");
            });

            modelBuilder.Entity<HealthCheck>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("healthcheck_pkey");

                entity.ToTable("healthcheck");

                entity.Property(e => e.Id)
                    .HasDefaultValueSql("gen_random_uuid()")
                    .HasColumnName("id");

                entity.Property(e => e.ApplicationId).HasColumnName("applicationid");
                entity.Property(e => e.CreatedAt).HasColumnName("createdat");
                entity.Property(e => e.Success).HasColumnName("success");

                entity.HasOne(d => d.ApplicationNavigation).WithMany(p => p.HealthCheckNavigation)
                    .HasForeignKey(d => d.ApplicationId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("healthcheck_applicationid_fkey");
            });

            modelBuilder.Entity<Log>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("log_pkey");

                entity.ToTable("log");

                entity.Property(e => e.Id)
                    .HasDefaultValueSql("gen_random_uuid()")
                    .HasColumnName("id");

                entity.Property(e => e.ApplicationId).HasColumnName("applicationid");

                entity.Property(e => e.Content).HasColumnName("content");

                entity.Property(e => e.CreatedAt).HasColumnName("createdat");

                entity.Property(e => e.Type)
                    .HasMaxLength(10)
                    .HasColumnName("type");

                entity.HasOne(d => d.ApplicationNavigation).WithMany(p => p.LogNavigation)
                    .HasForeignKey(d => d.ApplicationId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("log_applicationid_fkey");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
        
        public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            var result = await base.SaveChangesAsync(cancellationToken);
            ChangeTracker.Clear();
            return result;
        }
    }
}
